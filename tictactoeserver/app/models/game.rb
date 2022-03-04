class Game < ApplicationRecord


    
    #method for assigning players to positions (playerid = p1, playerid = p2)
    #method for handleing a move (playerid, position being) returns if move was valid, if it produced a winning result
    #method for calculating if a move wins

    #this method is terrible but I need to start somewhere to grok the syntax for defining a method and handling returns on a model
    def handle_turn(playerid, grid_position)
        
        #need to look at preventing out of turn or order moves
        #could use things like an incrementing or unique turn identifier to go along with move 
        #add guards in case square was already clicked on and other common scenarios
        
        #general logging to help trace as I wire things up
        puts(playerid, grid_position, gameid)

        #using playerids for grid position, not efficient on storage and would clean up
        #struggling with creating an empty array not a nil, nil array throws an undefined exception when writing to it
        #my create record for the seed data is set to boardstate: Array.new(9) but it is being returned as nil
        # if(boardstate == nil)
        #     boardstate = Array.new(9)    
        # end
        #puts("boardstate #{boardstate}")
        #boardstate[grid_position] = playerid


        #set next player
        p1_is_next = !p1_is_next


        #calculate if there is a winner
        puts(calculateWinner())

        #return
        return "is valid"

    
    end


    def calculateWinner()
        puts("calc if winner")
        return true
        #rough logic taken directly from ReactJS tictactoe tutorial
        # const lines = [
        #     [0, 1, 2],
        #     [3, 4, 5],
        #     [6, 7, 8],
        #     [0, 3, 6],
        #     [1, 4, 7],
        #     [2, 5, 8],
        #     [0, 4, 8],
        #     [2, 4, 6],
        #   ];
        #   for (let i = 0; i < lines.length; i++) {
        #     const [a, b, c] = lines[i];
        #     if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
        #       return squares[a];
        #     }
        #   }
        #   return null;
    end
end


# create_table :games do |t|
#     t.string :gameid
#     t.integer :boardstate, array: true, default: []
#     t.boolean :p1_is_next
#     t.timestamps