require "test_helper"

class GameTest < ActiveSupport::TestCase

  test "assign_player sets to player one if no player already assigned" do
    #arrange - ensure that a game exist
    game = Game.find_by(gameid: 'game1')
    assert_nil game #not ideal to have many guards in arrange portion but some makes sense when i'm learning lifecycles
    game = Game.create(gameid: "game1", p1_is_next: true, boardstate: Array.new(9,0), turn: 0)
    
    game.assign_player("player1id")

    #act - call get method on game and store game in variable
    assert_equal "player1id", game.player_one_id
  end

end
