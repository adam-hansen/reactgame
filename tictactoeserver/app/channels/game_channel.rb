class GameChannel < ApplicationCable::Channel
  
  def subscribed
    # stream_from "some_channel"

    #hardcoding this now, prep for different games in the future
    gameid = "game1"
    
    stream_from "game_#{gameid}"
    ActionCable.server.broadcast("game_#{gameid}", {body:"player connected #{uuid} to game #{gameid}"})

    @game = Game.find_by(gameid: 'game1')
    @game.assign_player(uuid)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #primary source of state changes, a player will make a move
  #return if a winner is found, should probably have a status object returned but this works to prove the frameworks
  def receive(data)
    
    if(data["grid_position"])
      gameid = "game1"

      @game = Game.find_by(gameid: gameid)
      @game.handle_turn(uuid, data["grid_position"]) 
      ActionCable.server.broadcast("game_#{gameid}", {winner: @game.handle_turn(uuid, data["grid_position"]) })
    end

  end
end
