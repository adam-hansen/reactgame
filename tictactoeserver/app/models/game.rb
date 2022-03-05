class Game < ApplicationRecord
    #this is super critical, the boardstate array will show up in the db, it can be queried, creating records from the seed will serialize correctly
    #BUT if you update a value without this, it will put it in the character position of the string and not the array index
    serialize :boardstate

    def assign_player(playerid)
        #should really stores players in a hash, doing it this way for now to avoid seralization issues with hash maps
        #focusing on geting the rest of the game logic up and i'll come back on this
        self.player_one_id.blank? ? ( self.player_one_id = playerid) : ( self.player_two_id = playerid)
        puts("player one = #{self.player_one_id} , player two = #{self.player_two_id }")

        self.save
    end
    
    #method for assigning players to positions (playerid = p1, playerid = p2)
    #method for handleing a move (playerid, position being) returns if move was valid, if it produced a winning result
    #method for calculating if a move wins

    #this method is terrible but I need to start somewhere to grok the syntax for defining a method and handling returns on a model
    def handle_turn(playerid, grid_position)
        
        #need to look at preventing out of turn or order moves
        #could use things like an incrementing or unique turn identifier to go along with move 
        #add guards in case square was already clicked on and other common scenarios
        
        #update grid positions
        self.boardstate[grid_position] = playerid
        puts(self.boardstate)

        #set next player
        self.p1_is_next = !p1_is_next


        #calculate if there is a winner
        calculateWinner()

        self.save

        #return
        return "is valid"
    end

    def reset
        self.boardstate = Array.new(9)
        self.p1_is_next = true
        self.player_one_id = nil
        self.player_two_id = nil
        self.save
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