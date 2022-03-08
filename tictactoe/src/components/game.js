import React from 'react';
import Board from './board';
import BoardStatus from './boardstatus';
import GameControls from './gamecontrols';

const p1symbol = 'X';
const p2symbol = 'O'
const gameApiUrl = "http://localhost:3001/game"

class Game extends React.Component {
    constructor (props){
        super(props);

        this.state = {
            squares: Array(9).fill(null),
            xIsNext: true,
            stepNumber: 0,
            playerPos: "",
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
                            winner: data.game.winner
                        });
                    } else if (data.playerpos) {
                        this.setState({
                            playerPos: data.playerpos
                        })
                    }
                }
        });
    }

    componentDidMount() {
        fetch(gameApiUrl)
            .then(data => data.json())
            .then(data => {
                console.log(data)
                this.setState({
                    xIsNext: data.p1_is_next,
                    stepNumber: data.turn,
                    squares: data.boardstate,
                });
            })
    }
    
    handleSquareClick(i){
        this.gameChannel.send({grid_position: i})
    }

    //should really have a generic set of commands to switch off of, this is just enough to get pipes in place
    handleResetClick(i){
        this.gameChannel.send({reset: true})
    }

    jumpTo(step) {
        this.setState({
            stepNumber: step,
            xIsNext: (step % 2) === 0,
        });
    }

    render() {

        //determine status to display
        let statusText;
        if(this.state.winner)
        {
            statusText = `Winner: ${this.state.winner}!`;
        } else {
            statusText = `Next player: ${(this.state.xIsNext ? p1symbol : p2symbol)}`;  
        }
        
        return (
        <div className="game">
            <div className="game-board">
                <div>
                    <BoardStatus value= {statusText}/>
                </div>
                <div>
                    <GameControls onClick = {(i) => this.handleResetClick()} />
                </div>
                <Board 
                    squares={this.state.squares}
                    onClick={(i) => this.handleSquareClick(i)}
                />
            </div>
        </div>
        );
    }
}

export default Game