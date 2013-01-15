require_relative '../lib/door'
require_relative '../lib/brush'

describe Brush do
  before do
    @brush = Brush.new(Door.new("000\n000\n001"))
  end

  describe '#paint?' do
    it 'should return true by just brush size' do
      @brush.paint?(2).should eql true
    end

    it 'should return false by big brush size' do
      @brush.paint?(3).should eql false
    end
  end

  describe '#size' do
    it 'should return just brush size for painting' do
      @brush.size.should eql 2
    end

    it 'should return just brush size for painting' do
      brush = Brush.new(Door.new(File.read('sample/10.txt')))
      brush.size.should eql 1
    end
  end
end
