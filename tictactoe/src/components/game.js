import React from 'react';
import Board from './board';
import BoardStatus from './boardstatus';

const p1symbol = 'X';
const p2symbol = 'O'

class Game extends React.Component {
    constructor (props){
        super(props);

        this.state = {
            history: [{
                squares: Array(9).fill(null)
            }],
            xIsNext: true,
            stepNumber: 0,
            playerid: ""
        };

        this.gameChannel = props.cableApp.cable.subscriptions.create({
                channel: 'GameChannel'
        },
        {
                received: (id) => {
                    this.state.setState({playerid:id});
                }
        });
    }
    
    handleClick(i){
        //history slices previous history at current stepnumber to allow moving backwards
        const history = this.state.history.slice(0, this.state.stepNumber + 1);
        const current = history[history.length -1];
        const squares = current.squares.slice();

        //handle case where someone has already clicked on square
        if(calculateWinner(squares) || squares[i])
        {
            return;
        }
        
        //set new value into square
        squares[i] = this.state.xIsNext ? p1symbol : p2symbol;
        this.setState({
            history: history.concat([{
                squares: squares,
            }]),
            xIsNext: !this.state.xIsNext,
            stepNumber: history.length,
        });

        this.gameChannel.send({i})
    }

    jumpTo(step) {
        this.setState({
            stepNumber: step,
            xIsNext: (step % 2) === 0,
        });
    }

    render() {
        //status text being calculated here and not in the board status component is sus
        const history = this.state.history;
        const current = history[this.state.stepNumber];
        const winner = calculateWinner(current.squares);

        const moves = history.map((step,move) => {
            const desc = move ?
                'Go to move #' + move :
                'Go to game start';
            return (
              <li key={move}>
                  <button onClick={() => this.jumpTo(move)}>{desc}</button>
              </li>  
            );
        });

        //determine status to display
        let statusText;
        if(winner)
        {
        statusText = `Winner: ${winner}!`;
        } else {
        statusText = `Next player: ${(this.state.xIsNext ? p1symbol : p2symbol)}`;  
        }
        

        return (
        <div className="game">
            <div className="game-board">
                <div>
                    <BoardStatus value= {statusText}/>
                </div>
                <Board 
                    squares={current.squares}
                    onClick={(i) => this.handleClick(i)}
                />
            </div>
            <div className="game-info">
                <ol>{moves}</ol>
            </div>
        </div>
        );
    }
}

function calculateWinner(squares) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (let i = 0; i < lines.length; i++) {
      const [a, b, c] = lines[i];
      if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
        return squares[a];
      }
    }
    return null;
  }


export default Game