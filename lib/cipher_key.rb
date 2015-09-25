class CipherKey

  attr_reader :key_table

  def initialize(key)
    ## if the key already contains all letters of alphabet and is correct length
    if all_letters?(key) && correct_length?(key)
      @key = key
    ## if key
    elsif too_short?(key)
      @key = format_key(key)
    else
      raise "Invalid key"
    end
    ## creates and saves the key table in instance variable
    @key_table = create_key_table
  end

  def all_letters?(str)
    ## Return true if string contains all characters except i or j
    letters = str.scan(/[a-z]/i)
    letters.uniq.length == 25
  end

  def correct_length?(str)
    str.length == 25
  end

  def too_short?(str)
    str.length < 25
  end


  def format_key(key)
    ## adds each letter of the key string to the letters array
    letters = key.scan(/[a-z]/i)
    ## removes any repeat letters
    letters.uniq!
    ## loop until all letters of alphabet are added to the string (i and j count as 1 letter)
    until letters.length == 25
      ## if letter includes j, exclude i from the
      if letters.include?("j")
        array = ('a'...'i').to_a + ('j'..'z').to_a
        array.each do |let|
          letters << let
        end
        letters.uniq!
      ## else add i and exlucde j
      else
        array = ('a'..'i').to_a + ('k'..'z').to_a
        array.each do |let|
          letters << let
        end
        letters.uniq!
      end
    end
    ## join letters array to create a single string and return
    letters.join
  end

  def create_key_table
    ## 2 dimensional array to hold table, 5 lines, 5 columns
    table = [[],[],[],[],[]]
    row_ind = 0
    ## add every 5 letters of the @key string to the lines array
    lines = @key.scan(/.{5}/)

    ## every line is 5 characters
    lines.each do |line|
      col_ind = 0
      ## on every char out of the 5 in line
      line.split('').each do |char|
        ## set the char at its corresponding point in the table
        table[row_ind][col_ind] = char
        col_ind += 1
      end
      row_ind += 1
    end
    table
  end

  def find_char(char)
    x = 0
    y = 0
    ## check every for char and set x and y coordinates when it is found
    @key_table.each do |line|
      y = line.index(char) if line.include?(char)
      x = @key_table.index(line) if line.include?(char)
    end
    ## return x and y coordinate in table (reverse y to give proper coordinate value)
    [x.to_i, y.to_i]
  end

end