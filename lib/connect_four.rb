class ConnectFour
    attr_accessor :board
    def initialize
       make_board 
       @player1 = 1
       @player2 = 2
    end
    def make_board
        @board =  Array.new(6) {Array.new(7, 0)} 
    end
    def place_piece(player, row, col) 
       
        @board[row][col] = player
        /display/
    end
    def drop_piece(player, col)
        row = 5
        @placed = false
        6.times do
            if @board[row][col] == 0
                place_piece(player, row, col)
                @placed = true
            elsif row >-1
                row -= 1
            end
        end
        if @placed == false
            puts "Column #{col+1} full, please enter a different one"
            take_turn(player)
        end
    end
    def take_turn(player)
        puts "Player #{player.to_s}, choose column (1-7)"
        play = gets.chomp.to_i
        if play>0 && play<8
            col = (play - 1)
        else 
            puts "Please enter valid column (1-7)"
        end
        return col
    end
    def vert_check
        i = 0
        j = 0        
        @temp_array = []
        @win = 0
        7.times do
            i=0 
            @temp_array = []
            6.times do
                @temp_array << @board[i][j]
                i += 1
            end            
            @win = array_win_check(@temp_array)
            if  @win == 1 || @win == 2
                return @win
            end
            j += 1
        end
        return 0
    end
    def diag_check
        @win = 0
        array_of_array = []
        temp_array = []
        #check right slant
        row_counter = 0
        col_counter = 0
        counter = 0
        col = 0
        @win = 0
        3.times do
            4.times do           
                row = 2 - row_counter
                col = col + col_counter
                temp_array = []
                4.times do
                    puts "row: #{row}.  col: #{col}"
                    temp_array << @board[row][col]                  
                    row +=1
                    col +=1
                end
                counter +=1
                @win = array_win_check(temp_array)
                if @win == 1 || @win == 2
                    return @win
                end
                col = 0
                col_counter +=1
            end
            col_counter = 0
            row_counter +=1
        end  
        return @win
    end
    def win_check
        @win = 0                                 #horizontal check
        @board.each do |row|
            @win = array_win_check(row)
            if @win == 1 || @win == 2
                return @win
            end
        end                            #VERTICAL check 
        /if @win == 0
            @win = vert_check
        end/ 
        if @win == 0
            @win = diag_check
        end                                #Diagonal check 
        if @win != nil
            return @win
        end
            
    end
    def array_win_check(array)
        i = 0
        @last_play = 0
        @running_total = 0
        @finished = false
        @win = 0
        puts "array_win_check array: #{array}"
        until @finished  do
            if array[i] == 1 || array[i] == 2                   
                if array[i] == @last_play     
                    @running_total +=1
                    @candidate = array[i]
                else
                    @running_total = 0
                end
                if @running_total > 2 
                    @win = @candidate
                    return @win
                    @finished = true
                end
                @last_play = array[i]
            end
            i += 1
            if array[i] == nil
                @finished = true
            end
        end
        return @win
    end
    def display
        puts "________________________________________________"
        6.times do |row|            
            7.times do |col| 
                print "|      "
            end
            puts "|\n"           
            7.times do |col| 
                if @board[row][col] != 0
                    if @board[row][col] == 1
                        print "|  #{"\u26AA".encode('utf-8')}  "
                    elsif @board[row][col] == 2
                        print "|  #{"\u26AB".encode('utf-8')}  "
                    end
                else
                    print "|      "
                end
            end
            puts "|\n"
            7.times do |col| 
                print "|______"
            end
            puts "| "
        end      
    end
end

/newgame = ConnectFour.new
newgame.display/

