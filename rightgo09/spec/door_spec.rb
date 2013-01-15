require_relative '../lib/door'

describe Door do
  before do
    @door = Door.new("000\n000\n000")
  end

  describe '#new' do
    it 'should raise error, because not square' do
      expect { Door.new("000\n000\n0000") }.to raise_error
    end
  end
  describe '#size' do
    it 'should return square size' do
      @door.size.should eql 3
    end
  end
  describe '#white_cell' do
    it 'should become false cell painted falg' do
      @door.cells[0][0].painted = true
      @door.white_cell
      @door.cells[0][0].painted.should == false
    end
  end

  describe Door::Cell do
    describe '#window?' do
      it 'should return window flag' do
        Door::Cell.new('0').should_not be_window
        Door::Cell.new('1').should be_window
      end
    end
  end
end
