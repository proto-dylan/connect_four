require './lib/connect_four.rb'


describe ConnectFour do

    describe '#make_board' do
        
        it "creates an array for the game board" do
            game = ConnectFour.new
            expect(game.board).to be_an_instance_of(Array)   
        end
        it "creates a blank grid of 0s, 6 rows by 7 columns" do
            game = ConnectFour.new
        
            ary = [
                [0, 0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0, 0], 
                [0, 0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0, 0]
              ]
            expect(game.board).to eql(ary)
        end
    end

    describe '#place_piece' do
        game = ConnectFour.new

        it "places a game piece of player1 at board[0][0]" do
            row = 0
            col = 0
            game.place_piece(1, row, col)
            expect(game.board[0][0]).to eql(1)
        end
    end
    describe '#drop_piece' do
        newgame = ConnectFour.new

        it "drops piece to the lowest open row from top of column 1" do
            col = 0
            newgame.drop_piece(1, col)
            expect(newgame.board[5][0]).to eql(1)
        end
        it "drops piece on top of previous" do
            col = 0 
            newgame.drop_piece(2, col)
            expect(newgame.board[4][0]).to eql(1)
        end
    end
    /describe '#take_turn' do
        newgame1 = ConnectFour.new

        it "prompts player 1 first" do
            player = 1
            newgame1.take_turn(player)
            allow($stdin).to receive(:gets).and_return(1)
            play = $stdin.gets
            
            expect(play).to eql(1)
        end
        it "doesn't accept an invalid column" do
            player = 2
            newgame1.take_turn(player)
            allow($stdin).to receive(:gets).and_return(nil)
            play = $stdin.gets

            expect(play).to eql(nil)
        end
        it "contiues asking for a valid col until given" do
            player = 2
            newgame1.take_turn(player)
            allow($stdin).to receive(:gets).and_return(1)
            play = $stdin.gets

            expect(play).to eql(1)
        end
        it "wont let you play on a full column" do
            player = 1
            newgame1.take_turn(player)
            newgame1.board =  [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [2, 0, 0, 0, 0, 0, 0], 
                [2, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0]
              ]

            newgame1.drop_piece(1, 1)
            expect(@placed).to eql(nil)

        end

    end/

    describe '#array_win_check' do

        it "sends 0 for fail" do
            newgame = ConnectFour.new
        array = [1,1,2,2,0,1]
        win = newgame.array_win_check(array)
        expect(win).to eql(0)
        end
        it "sends 1 for 1 win" do
            newgame = ConnectFour.new
        array = [1,1,1,1,0,2]
        win = newgame.array_win_check(array)
        expect(win).to eql(1)
        end
        it "sends 2 for 2 win" do
            newgame = ConnectFour.new
        array = [1,1,2,2,2,2]
        win = newgame.array_win_check(array)
        expect(win).to eql(2)
        end
        
    end

    describe '#diag_check' do
        newgame = ConnectFour.new

        it "returns appropriate diag array" do

            newgame.board = [
                [0, 0, 0, 0, 0, 0, 0],
                [1, 1, 1, 1, 0, 0, 0],
                [2, 2, 2, 2, 0, 0, 0], 
                [2, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 1, 0],
                [1, 2, 2, 1, 1, 0, 0]
            ]

            array = newgame.diag_check
            expect(array).to eql(0)
        
        end


    end

    describe '#win_check' do
        newgame3 = ConnectFour.new

        /it "checks for a  fail" do
            newgame3.board = [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [2, 0, 0, 0, 0, 0, 0], 
                [2, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 1, 0],
                [1, 2, 2, 1, 1, 0, 0]
              ]
              newgame3.display
              win = newgame3.win_check
              expect(win).to eql(0)

        end

        it "checks for a win of 4 horizontal pieces" do
            newgame3.board = [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [2, 0, 0, 0, 0, 0, 0], 
                [2, 0, 0, 0, 0, 0, 0],
                [0, 0, 1, 1, 1, 1, 0],
                [1, 2, 2, 1, 1, 0, 0]
              ]
              newgame3.display
              win = newgame3.win_check
              expect(win).to eql(1)

        end
        it "checks for a win of 4 horizontal pieces" do
            newgame3.board = [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [2, 0, 0, 0, 0, 0, 0], 
                [2, 0, 0, 0, 0, 0, 0],
                [1, 1, 1, 1, 0, 0, 0],
                [1, 2, 2, 1, 1, 0, 0]
              ]
              newgame3.display
              win = newgame3.win_check
              expect(win).to eql(1)

        end
       



        it "checks for vertical fail" do
            newgame3.board =  [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [2, 0, 0, 0, 0, 0, 0], 
                [2, 0, 0, 1, 0, 0, 0],
                [1, 1, 0, 1, 0, 0, 0],
                [1, 2, 2, 1, 1, 0, 0]
              ]
              newgame3.display
              win = newgame3.win_check
              expect(win).to eql(0)  
        end


       it "checks for vertical win" do
            newgame3.board =  [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [2, 0, 0, 1, 0, 0, 0], 
                [2, 0, 0, 1, 0, 0, 0],
                [1, 1, 0, 1, 0, 0, 0],
                [1, 2, 2, 1, 1, 0, 0]
              ]
              newgame3.display
              win = newgame3.win_check
              expect(win).to eql(1)  
        end/
        it "checks for diagonal win [0][2]to[3][5]" do
            newgame3.board =  [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0], 
                [2, 1, 0, 1, 0, 0, 0],
                [1, 1, 1, 0, 0, 0, 0],
                [1, 2, 2, 1, 1, 0, 0]
            ]
            newgame3.display
            win = newgame3.win_check
            expect(win).to eql(1)

        end

        it "checks for diagonal win [3][5]to[6][5]" do
            newgame3.board =  [
                [1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0, 0, 0],
                [0, 0, 0, 1, 0, 0, 0], 
                [2, 0, 0, 1, 1, 0, 0],
                [1, 1, 1, 0, 0, 1, 0],
                [1, 2, 2, 1, 1, 0, 1]
            ]
            newgame3.display
            win = newgame3.win_check
            expect(win).to eql(1)

        end
    end
end


