require "test_helper"

class GameTest < ActiveSupport::TestCase

  test "assign_player sets to player one if no player already assigned" do
    #arrange - ensure that a game exist
    game = Game.find_by(gameid: 'game1')
    assert_nil game #not ideal to have many guards in arrange portion but some makes sense when i'm learning lifecycles
    game = Game.create(gameid: "game1", p1_is_next: true, boardstate: Array.new(9,0), turn: 0)
    
    game.assign_player("player1id")

    assert_equal "player1id", game.player_one_id
  end

  test "assign_player sets to player two if player one already assigned" do
    #arrange - ensure that a game exist
    game = Game.find_by(gameid: 'testgameid')
    assert_nil game #not ideal to have many guards in arrange portion but some makes sense when i'm learning lifecycles
    game = Game.create(gameid: "testgameid", p1_is_next: true, boardstate: Array.new(9,0), turn: 0, player_one_id: "testplayerid")
    
    game.assign_player("playertwoid")

    assert_equal "testplayerid", game.player_one_id
    assert_equal "playertwoid", game.player_two_id
  end

end
