require_relative 'cipher_key'

class Encrypt

  attr_reader :raw_message

  def initialize(raw_message)
    @raw_message = raw_message
    @encoded_message = ''
    @newkey = CipherKey.new("playfairexample")
  end

  def encrypt
    ## split string into substrings of length 2
    message = @raw_message
    msg = ''
    prev_char = ''
    ## removes white space from message and execute block on each character
    message.gsub(/\s+/, "").split('').each do |substr|
      ## add previous character to the string
      msg << prev_char
      ## adds x after the previous character if it repeats itself
      msg << "x" if substr == prev_char
      prev_char = substr
    end
    ## add final character to message as it is not included in previous characters
    msg << message.split('').last
    ## split message up into substrings, each with a length of 2 characters
    substrs = msg.scan(/.{1,2}/)
    ## if there is an odd amount of chars, add x to the end to make it even
    substrs[substrs.length - 1] += "x" if @raw_message.gsub(/\s+/, "").length % 2 == 1
    ## each substring
    substrs.each do |substr|
      coord = []
      ## each char in substring
      substr.split('').each do |char|
        ## add coordinates to the coordinates array
        coord << @newkey.find_char(char.downcase)
      end
      x1 = coord[0][0]; x2 = coord[1][0]; y1 = coord[0][1]; y2 = coord[1][1]
      if x1 == x2
        @encoded_message << "#{same_row(coord)}"
      elsif y1 == y2
        @encoded_message << "#{same_col(coord)}"
      else
        @encoded_message << "#{rectangle(coord)}"
      end
    end
    @encoded_message
  end

  def same_row(coordinates)
    key = @newkey.key_table
    x1 = coordinates[0][0]; x2 = coordinates[1][0]; y1 = coordinates[0][1] + 1; y2 = coordinates[1][1] + 1
    ## wrap round to left if it is the final value in row
    y1 = 0 if y1 == 5; y2 = 0 if y2 == 5
    "#{key[x1][y1]}" + "#{key[x2][y2]}"
  end

  def same_col(coordinates)
    key = @newkey.key_table
    x1 = coordinates[0][0] + 1; x2 = coordinates[1][0] + 1; y1 = coordinates[0][1]; y2 = coordinates[1][1]
    ## wrap round to top if it is the bottom value in column
    x1 = 0 if x1 == 5; x2 = 0 if x2 == 5
    "#{key[x1][y1]}" + "#{key[x2][y2]}"
  end

  def rectangle(coordinates)
    key = @newkey.key_table
    x1 = coordinates[0][0]; x2 = coordinates[1][0]; y1 = coordinates[0][1]; y2 = coordinates[1][1]
    "#{key[x1][y2]}" + "#{key[x2][y1]}"
  end

end

encrypt = Encrypt.new("Hide the gold in the tree stump")
puts "\n\nmessage => " + "#{encrypt.raw_message}\n\n"
puts "encoded message => " + encrypt.encrypt
