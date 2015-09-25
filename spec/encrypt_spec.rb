require 'spec_helper'
require 'encrypt'

describe Encrypt do
let(:encrypt) {Encrypt.new("Hide the gold in the tree stump")}
let(:raw_message) {encrypt.instance_variable_get(:@raw_message)}

  context 'initialize' do
    it 'takes a string and stores it in an instance variable' do
      expect(raw_message).to eq(raw_message)
    end
  end

  context 'encrypt' do
    let(:expected_result) {"bmodzbxdnabekudmuixmmouvif"}
    it "returns encoded message" do
      expect(encrypt.encrypt).to eq(expected_result)
    end

  end

  context 'same_row' do
    let(:coords) {[[0,0],[0,1]]}
    it "returns characters to the immediate right in the cipher key to the encoded message string" do
      expect(encrypt.same_row(coords)).to eq("la")
    end
  end

  context 'same_col' do
    let(:coords) {[[0,0],[1,0]]}
    it "returns characters immediately below in the cipher key to the encoded message string" do
      expect(encrypt.same_col(coords)).to eq("ib")
    end
  end

  context 'rectangle' do
    let(:coords) {[[4,3],[0,1]]}
    it "returns characters opposite ends of rectangle in the cipher key to the encoded message string" do
      expect(encrypt.rectangle(coords)).to eq("uy")
    end
  end
end