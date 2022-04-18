require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest

  #Need to dig into naming convetions in ruby/rails for test
  #I always liked the "When / If / Then" naming structure
  #for example "when game controller invoked if game exist game returned"
  #for example "when game controller invoked if no game exist not found returned"
  test "the truth" do
    assert true
  end

  test "game returned if exist" do
    #arrange - ensure that a game exist
    game = Game.find_by(gameid: 'game1')
    assert_nil game #not ideal to have many guards in arrange portion but some makes sense when i'm learning lifecycles
    Game.create(gameid: "game1", p1_is_next: true, boardstate: Array.new(9,0), turn: 0)

    #act - call get method on game and store game in variable
    get Rails.application.routes.url_helpers.game_index_path

    #assert
    assert_response :success
    assert_not_nil @response.body
  end

  test "null and 200 returned for game that doesn't exist" do
    #arrange - ensure that a game exist
    game = Game.find_by(gameid: 'game2')
    assert_nil game #not ideal to have many guards in arrange portion but some makes sense when i'm learning lifecycles

    #act - call get method on game and store game in variable
    get Rails.application.routes.url_helpers.game_index_path

    #assert
    assert_response :success
    assert @response.body == 'null'
  end

end


# def index
#   #load current state of a game
#   #search for an open game with the id
#   #so this is not ideal as gameid is not an indexed field but I haven't built logic to get the dynamically calculated game id so this works for now
#   #@game = Game.find_by(gameid: 'game1')
#   game = Game.find_by(gameid: 'game1')
#   render json: game
# end