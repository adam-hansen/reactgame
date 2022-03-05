class GameChannel < ApplicationCable::Channel
  
  def subscribed
    # stream_from "some_channel"

    #hardcoding this now, prep for different games in the future
    gameid = "game1"
    
    stream_from "game_#{gameid}"
    ActionCable.server.broadcast("game_#{gameid}", {body:"player connected #{uuid} to game #{gameid}"})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #primary source of state changes, a player will make a move
  def receive(data)
    #puts(uuid, data)

    if(data["grid_position"])
      @game = Game.find_by(gameid: 'game1')
      @game.handle_turn(uuid, data["grid_position"]) 
    end
    
    #user's id is on the channel
    #move is the specific square taken
    #logic in game should track which user is which piece  
  end
end
