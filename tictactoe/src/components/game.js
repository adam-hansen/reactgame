import React from 'react';
import Board from './board';
import BoardStatus from './boardstatus';

const p1symbol = 'X';
const p2symbol = 'O'

class Game extends React.Component {
    constructor (props){
        super(props);

        this.state = {
            squares: Array(9).fill(null),
            xIsNext: true,
            stepNumber: 0,
            playerid: "",
            winner: "",
        };

        this.gameChannel = props.cableApp.cable.subscriptions.create({
                channel: 'GameChannel'
        },
        {
                received: (data) => {

                    console.log(data)
                    if(data.game)
                    {
                        console.log("data.boardstate returned true, setting state")
                        this.setState({
                            xIsNext: data.game.p1_is_next,
                            stepNumber: data.game.turn,
                            squares: data.game.boardstate,
                        });
                    }
                }
        });
    }
    
    handleClick(i){
        //history slices previous history at current stepnumber to allow moving backwards
        // const history = this.state.history.slice(0, this.state.stepNumber + 1);
        // const current = history[history.length -1];
        // const squares = current.squares.slice();

        // //handle case where someone has already clicked on square
        // if(calculateWinner(squares) || squares[i])
        // {
        //     return;
        // }
        
        // //set new value into square
        // squares[i] = this.state.xIsNext ? p1symbol : p2symbol;
        // this.setState({
        //     history: history.concat([{
        //         squares: squares,
        //     }]),
        //     xIsNext: !this.state.xIsNext,
        //     stepNumber: history.length,
        // });

        this.gameChannel.send({grid_position: i})

    }

    jumpTo(step) {
        this.setState({
            stepNumber: step,
            xIsNext: (step % 2) === 0,
        });
    }

    render() {
        //status text being calculated here and not in the board status component is sus
        // const history = this.state.history;
        // const current = history[this.state.stepNumber];
        // const winner = calculateWinner(current.squares);

        // const moves = history.map((step,move) => {
        //     const desc = move ?
        //         'Go to move #' + move :
        //         'Go to game start';
        //     return (
        //       <li key={move}>
        //           <button onClick={() => this.jumpTo(move)}>{desc}</button>
        //       </li>  
        //     );
        // });

        //determine status to display
        let statusText;
        if(this.state.winner)
        {
            statusText = `Winner: ${this.state.winner}!`;
        } else {
            statusText = `Next player: ${(this.state.xIsNext ? p1symbol : p2symbol)}`;  
        }
        
        var squarestorender = this.state.squares;
        //var squarestorender = Array(9).fill(null);

        return (
        <div className="game">
            <div className="game-board">
                <div>
                    <BoardStatus value= {statusText}/>
                </div>
                <Board 
                    squares={squarestorender}
                    onClick={(i) => this.handleClick(i)}
                />
            </div>
        </div>
        );
    }
}

export default Game