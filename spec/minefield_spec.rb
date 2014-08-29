require 'rspec'
require_relative '../minefield'

describe Minefield do

  let(:minefield) { Minefield.new(5,5,3) }

  describe '#cell_cleared?' do
    it 'returns false for a cell that has not been clicked' do
      expect(minefield.cell_cleared?(0,0)).to eq(false)
    end

    it 'returns true for a cell that has been cleared' do
      minefield.clear(0,0)
      expect(minefield.cell_cleared?(0,0)).to eq(true)
    end
  end

  describe '#any_mines_detonated?' do
    it 'returns true if a mine has been clicked on' do
      minefield = Minefield.new(5,5,25)
      minefield.clear(1,1)
      expect(minefield.any_mines_detonated?).to eq(true)
    end

    it 'returns false if there are no mines in minefield' do
      minefield = Minefield.new(5,5,0)
      minefield.clear(1,1)
      expect(minefield.any_mines_detonated?).to be false
    end

  end

end

