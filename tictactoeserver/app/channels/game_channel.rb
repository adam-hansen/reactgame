class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"

    stream_from "player_#{uuid}"
    ActionCable.server.broadcast("player_#{uuid}", {body:"player connected #{uuid}"})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
