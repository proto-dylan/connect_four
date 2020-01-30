class ConnectFour
    attr_accessor :board, :player1_symbol, :player2_symbol
    def initialize
       make_board 
       @player1 = 1
       @player2 = 2
       @player1_symbol = ''
       @player2_symbol = ''
        welcome
        get_symbols
       
    end
    def make_board
        @board =  Array.new(6) {Array.new(7, 0)} 
    end
    def welcome
        puts "\n\n\n\n\n\n\n\n\n\n"
        puts "                          Welcome.  "
        puts "        Put on your playin' pants, 'cuz its gon' git nasty "
        puts "\n\n"
        puts "                    GAME:  Connect Four "
        puts "                    RULES:  connect four"
        puts "\n\n"
        puts "                         ENGAGE!"
        puts "\n\n\n\n"
    end
    def get_symbols(player = 1)
        #puts "\n\n\n\n"
        puts "                  Player #{player}, choose your symbol\n\n\n"        
        puts "              1) #{"\u26AA".encode('utf-8')}"
        puts "              2) #{"\u26AB".encode('utf-8')}"
        puts "              3) #{"\u2693".encode('utf-8')}"
        puts "              4) #{"\u266B".encode('utf-8')}"
        puts "              5) #{"\u26DF".encode('utf-8')}"
        puts "              6) #{"\u26A1".encode('utf-8')}"
        puts "              7) #{"\u26F4".encode('utf-8')}"
        puts "              8) #{"\u261D".encode('utf-8')}\n\n\n\n\n\n\n\n"
        choice = gets.chomp.to_i
        puts "\n\n\n\n\n\n\n"
       
        if (1..8).include?(choice)
            case choice
           
            when 1
                current_symbol = "\u26AA"
            when 2
                current_symbol = "\u26AB"
            when 3
                current_symbol = "\u2693"
            when 4
                current_symbol = "\u266B "
            when 5
                current_symbol = "\u26DF "
            when 6
                current_symbol = "\u26A1"
            when 7
                current_symbol = "\u26F4 "
            when 8
                current_symbol = "\u261D "
            else
                get_symbols(player)
            end
        end
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        if player == 1
            @player1_symbol = current_symbol
            player = 2
            get_symbols(player)
        elsif player ==2
            if @player2_symbol != @player1_symbol
                @player2_symbol = current_symbol
            else
                puts "Player 1 chose that one, choose another"
                get_symbols(player)
            end  
        end
    end    
    def place_piece(player, row, col)   
        @board[row][col] = player
    end
    def play_game
        
        puts "SYMBOLSin 1: #{@player1_symbol},   2:#{@player2_symbol}"
        winner = false
        player = 1 
        col = 0
        until winner do
            display
            take_turn(player)
            if win_check == 1 || win_check == 2
                display
                winner = true
                puts "\n\n\nPlayer #{player} wins, play again? (y,n)\n\n\n"
                answer = gets.chomp
                if answer == 'y' || answer == 'Y'
                    new_game = ConnectFour.new
                    new_game.play_game
                end                   
            end
            if player == 1
                player = 2
            else
                player = 1
            end
        end
    end
    def drop_piece(player, col)
        row = 5
        @placed = false
        6.times do
            if @board[row][col] == 0
                place_piece(player, row, col)
                @placed = true
                break
            elsif row >-1
                row -= 1
            end
        end
        if @placed == false
            puts "Column #{col+1} full"
            take_turn(player)
        end
    end
   
    def take_turn(player)
       
        puts "         Player #{player.to_s}, choose column (1-7)"
        puts "\n\n" 
        play = gets.chomp.to_i
        if play !=  0
            if play>0 && play<8
                col = (play - 1)
            else
                puts "Please enter valid column (1-7)"
            end
            drop_piece(player, col)
        else
            take_turn(player)
        end
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
        row_counter = 0       
        col_counter = 0  
        counter = 0
        col = 0
        rev_col = 6                  #reverse counter mirrors left to right diag
        @win = 0
        3.times do
            4.times do                          
                row = 2 - row_counter
                col = col + col_counter
                rev_col = rev_col - col_counter
                temp_array = []
                rev_temp_array = []                      
                4.times do
                   # puts "row: #{row}.  col: #{col}. rev_col: #{rev_col}"                    
                    temp_array << @board[row][col] 
                    rev_temp_array << @board[row][rev_col]                 
                    row +=1
                    col +=1
                    rev_col -= 1
                end
                counter +=1
                @win = array_win_check(temp_array)
                if @win == 0
                    @win = array_win_check(rev_temp_array)     #if left-right isnt a win, check reverse
                end
                if @win == 1 || @win == 2
                    return @win
                end
                col = 0
                rev_col = 6
                col_counter +=1
            end
            col_counter = 0
            row_counter +=1
        end  
        return @win
    end
    def win_check
        @win = 0                                
        @board.each do |row|
            @win = array_win_check(row)
            if @win == 1 || @win == 2
                return @win
            end
        end                            
        if @win == 0
            @win = vert_check
        end 
        if @win == 0
            @win = diag_check
        end                               
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
            elsif array[i] == 0
                @running_total = 0                 #Reset total here for in-row 0's
            end
            i += 1
            if array[i] == nil
                @finished = true
            end
        end
        return @win
    end
    def display

        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n"
        puts "    1      2      3      4      5      6      7  "
        puts " ________________________________________________"
        6.times do |row|            
            7.times do |col| 
                print "|      "
            end
            puts "|\n"           
            7.times do |col| 
                if @board[row][col] != 0
                    if @board[row][col] == 1
                        print "|  #{@player1_symbol}  "
                    elsif @board[row][col] == 2
                        print "|  #{@player2_symbol}  "
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
        puts "\n\n"
        puts "          Player 1: #{@player1_symbol}     Player 2: #{@player2_symbol}"
        puts "\n\n\n\n\n\n"     
    end
end


new_game = ConnectFour.new
new_game.play_game





