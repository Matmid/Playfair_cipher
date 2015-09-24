require 'spec_helper'
require 'encrypt'

describe Encrypt do

  context 'initialize' do
    it 'takes a string and stores it in an instance variable'
  end

  context 'encrypt' do
    it "splits string into array of substrings of 2 characters each"

    it "appends 'x' to final substr if odd number of chars"

    it "finds each char in a substring in the cipher key"

    it "finds correct characters and appends it to the encryted message"

    it "returns encrypted message with same amount of characters (+1 if odd) as original string"
  end

end