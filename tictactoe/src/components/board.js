import React from 'react';
import BoardStatus from './boardstatus';
import Square from './square';

const p1symbol = 'X';
const p2symbol = 'O'

class Board extends React.Component {
  constructor (props){
    super(props);
    this.state = {
      squares: Array(9).fill(null),
      xIsNext: true,
    };
  }
      
  handleClick(i){
    const squares = this.state.squares.slice();

    //handle case where someone has already clicked on square
    if(squares[i] == null)
    {
      squares[i] = this.state.xIsNext ? p1symbol : p2symbol;
        this.setState({
        squares: squares,
        xIsNext: !this.state.xIsNext
      });
    }    
  }

  renderSquare(i) {
    return (
      <Square 
        value={this.state.squares[i]} 
        onClick={() => this.handleClick(i)}
      />
    );
  }

  render() {

    //status text being calculated here and not in the board status component is sus
    const winner = calculateWinner(this.state.squares);

    var statusText = '';
    if(winner)
    {
      statusText = `Winner: ${winner}!`;
    } else {
      statusText = `Next player: ${(this.state.xIsNext ? p1symbol : p2symbol)}`;  
    }
    

    return (
      <div>
        <div className="board-status">
          <BoardStatus value= {statusText}/>
        </div>
        <div className="board-row">
          {this.renderSquare(0)}
          {this.renderSquare(1)}
          {this.renderSquare(2)}
        </div>
        <div className="board-row">
          {this.renderSquare(3)}
          {this.renderSquare(4)}
          {this.renderSquare(5)}
        </div>
        <div className="board-row">
          {this.renderSquare(6)}
          {this.renderSquare(7)}
          {this.renderSquare(8)}
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

export default Board;