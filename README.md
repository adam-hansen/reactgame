# reactgame
[![CircleCI](https://circleci.com/gh/adam-hansen/reactgame/tree/main.svg?style=svg)](https://circleci.com/gh/adam-hansen/reactgame/tree/main)

# commands to start
navigate to tictactoe and do npm start (react app using node framework for handling stuff)
navigate to tictactoeserver and do rails s (ruby on rails API)


# planning notes
Notes to make a backend API so game can be played with multiplayer

Need to move all board calculations to server

Need to focus on inputs

Game input -> API -> state -> Response

Need to also look at patterns for keeping it in sync, how does react/ruby do things like websockets for signalr

Actioncable is a react / rubyrails friendly websocket framework with client and server components

Setup a single channel keyed by game ID to transfer all data


//Inputs
player name
sessionid
request to start
square selection

//State
Players
Session (use a user provided session ID to bootstrap app)

//references
https://dev.to/brandonbrown4792/web-sockets-with-rails-6-and-reactjs-2c45
https://www.cookieshq.co.uk/posts/tic-tac-toe-game-in-rails-5-with-action-cable 


//TODO So I don't forget
return game from controller with current state and wire that up to refresh FE
Add inputs to FE for selecting a room, selecting a player slot, and for reseting the game
These 3 things would allow for a reasonable number of users to play at the same time, games could also be spectated a