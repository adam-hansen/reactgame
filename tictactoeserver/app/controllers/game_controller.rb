class GameController < ApplicationController
    def index
        #load current state of a game
        #search for an open game with the id
        #so this is not ideal as gameid is not an indexed field but I haven't built logic to get the dynamically calculated game id so this works for now
        #@game = Game.find_by(gameid: 'game1')
        game = Game.find_by(gameid: 'game1')
        render json: game
    end
end
