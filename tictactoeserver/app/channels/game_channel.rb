class GameChannel < ApplicationCable::Channel
  
  #using this as a variable as ideally this is input to allow multiple games at the same time
  Gameid = "game1"

  def subscribed

    stream_from "game_#{Gameid}"

    @game = Game.find_by(gameid: Gameid)
    @game.assign_player(uuid)

    ActionCable.server.broadcast("game_#{Gameid}", {message:"player connected #{uuid} to game #{Gameid}"})

    #I thought about creating a seperate channel for player, that way player specific messages go back to the player while game state goes to all
    #out of time to implement
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #primary source of state changes, a player will make a move
  #return if a winner is found, should probably have a status object returned but this works to prove the frameworks
  def receive(data)
    
    if(data["grid_position"])

      @game = Game.find_by(gameid: Gameid)
      @game.handle_turn(uuid, data["grid_position"]) 

    else(data["reset"])
      
      @game = Game.find_by(gameid: Gameid)
      @game.reset 

    end

    ActionCable.server.broadcast("game_#{Gameid}", {game: @game})
  end
end
