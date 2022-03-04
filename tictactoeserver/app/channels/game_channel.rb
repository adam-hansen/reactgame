class GameChannel < ApplicationCable::Channel
  
  def subscribed
    # stream_from "some_channel"

    #hardcoding this now, prep for different games in the future
    gameid = "game1"
    
    stream_from "game_#{gameid}"
    ActionCable.server.broadcast("game_#{gameid}", {body:"player connected #{uuid} to game #{gameid}"})

    #map to current game for future messages
    @game = Game.find_by(gameid: 'game1')
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #primary source of state changes, a player will make a move
  def receive(data)
    #puts(uuid, data)

    if(data["grid_position"])
      @game.handle_turn(uuid, data["grid_position"]) 
    end
    
    #user's id is on the channel
    #move is the specific square taken
    #logic in game should track which user is which piece  
  end
end
