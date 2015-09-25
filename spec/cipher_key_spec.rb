require 'spec_helper'
require 'cipher_key'

describe CipherKey do
let(:cipherkey) {CipherKey.new("playfairexample")}
let(:valid_key) {"abcdefghiklmnopqrstuvwxyz"}

  context 'all_letters' do
    let(:invalid_key) {"notavalidkeyqwermsnajskde"}

    it "returns true if string contains every letter in the alphabet (i and j are counted as same)" do
      expect(cipherkey.all_letters?(valid_key)).to eq(true)
    end

    it "returns false if string does not contains every letter in the alphabet (i and j are counted as same)" do
      expect(cipherkey.all_letters?(invalid_key)).to eq(false)
    end
  end

  context 'correct_length?' do
    let(:invalid_key_length) {"abcdefghiklmnopqrstuvwxy"}

    it "returns true if the string is 25 characters long" do
      expect(cipherkey.correct_length?(valid_key)).to eq(true)
    end

    it "returns false if the string is not 25 characters long" do
      expect(cipherkey.correct_length?(invalid_key_length)).to eq(false)
    end

  end

  context 'too_short?' do
    let(:short_key_length) {"abcdefghiklmnopqrstuvwxy"}
    let(:long_key_length) {"abcdefghiklmnopqrstuvwxyasdasd"}

    it "returns true if the string is less than 25 characters long" do
      expect(cipherkey.too_short?(short_key_length)).to eq(true)
    end

    it "returns false if the string 25 characters or longer" do
      expect(cipherkey.too_short?(long_key_length)).to eq(false)
    end

  end

  context 'format_key' do
      let(:key) {"playfairexample"}
      it "returns a string that contains every letter in the alphabet (i and j are counted as same)" do
        expect(cipherkey.format_key(key)).to eq("playfirexmbcdghknoqstuvwz")
      end
  end

  context 'key_table' do
    it "returns a 2 dimensional table array with a length of 5" do
      expect(cipherkey.key_table.length).to eq(5)
    end

    it "each sub array in the table array will be a length of 5" do
      cipherkey.key_table.each do |array|
        expect(array.length).to eq(5)
      end
    end

    it "metches the key initialised in the cipherkey class" do
      expect(cipherkey.key_table.join).to eq(cipherkey.instance_variable_get(:@key))
    end
  end

  context 'find_char' do
    it "returns an array with the correct x and y coordinate of char in the key table" do
      expect(cipherkey.find_char('h')).to eq([2,4])
    end
  end

end