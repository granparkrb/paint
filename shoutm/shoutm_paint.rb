require "rspec"
 
class Painter
  attr_accessor :cellmap
 
  def initialize(cellmap)
    @cellmap = cellmap
    @size = cellmap.size # size x and size y are expected equal.
  end
 
  def get_max_brush_size
    1.upto(@size) do |max_brush_size|
      return max_brush_size - 1 unless brushable? max_brush_size
    end
    @size
  end
 
  private
 
  def brushable?(brush_size)
    painted_map = Marshal.load(Marshal.dump(@cellmap))
    0.upto(@size - 1) do |y|
      0.upto(@size - 1) do |x|
        paint(painted_map, x, y, brush_size) if paintable?(x, y, brush_size)
      end
    end
    ! painted_map.flatten.find do |elm| elm != 1 end
  end
 
  def paintable?(x, y, brush_size) # brush_size is expected >= 1
    return false if [x, y].max + brush_size > @size
    y.upto(y + brush_size - 1) do |yy|
      x.upto(x + brush_size - 1) do |xx|
        return false if @cellmap[yy][xx] != 0
      end
    end
    true
  end
 
  # Paint painted_map "brush_size square" from (x, y)
  # If there are no "brush_size square" space from (x, y), it is not painted.
  def paint(painted_map, x, y, brush_size)
    return if [x, y].max + brush_size > @size
    y.upto(y + brush_size - 1) do |yy|
      x.upto(x + brush_size - 1) do |xx|
        painted_map [yy][xx] = 1
      end
    end
  end
end
 
def main
  firstline = STDIN.gets.chomp
  size = firstline.chomp.split(' ').size
 
  # This is a 2-dimension array to store input values
  cellmap = Array.new
  # put first row to cellmap
  cellmap << firstline.split(' ').collect do |x| x.to_i end
 
  # read other input values from standard input
  (size - 1).times do |count|
    cellmap << STDIN.gets.chomp.split(' ').collect do |x| x.to_i end
  end
 
  puts "A suitable brush size is #{Painter.new(cellmap).get_max_brush_size}"
end
 
main
 
describe Painter do
  it "should initialize" do
    cellmap = [[1,2,3],[4,5,6],[7,8,9]]
    cellmap2 = [[1,2,3],[4,5,6],[7,8,9]]
    painter = Painter.new(cellmap)
    painter.cellmap.should == cellmap2
  end
 
  it "should get max brush size" do
    cellmap1 = [[0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,1,1,0,0],
                [0,0,1,1,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0]]
    cellmap2 = [[0,0,0,0,0],
                [0,1,0,1,0],
                [0,0,1,0,0],
                [0,1,0,1,0],
                [0,0,0,0,0]]
    cellmap3 = [[0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0]]
    cellmap4 = [[0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,1,1,1],
                [0,0,0,1,0,0,0],
                [0,0,0,1,0,0,0],
                [0,0,0,1,0,0,0]]
    cellmap5 = [[0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0],
                [0,0,0,0,1,1,1],
                [0,0,0,1,0,0,0],
                [0,0,0,1,0,0,0],
                [0,0,0,0,0,0,0]]
    Painter.new(cellmap1).get_max_brush_size.should == 2
    Painter.new(cellmap2).get_max_brush_size.should == 1
    Painter.new(cellmap3).get_max_brush_size.should == 6
    Painter.new(cellmap4).get_max_brush_size.should == 3
    Painter.new(cellmap5).get_max_brush_size.should == 1
  end
 
  it "should brushable?" do
    cellmap1 = [[0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,1,1,0,0],
                [0,0,1,1,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0]]
    Painter.new(cellmap1).send("brushable?", 2).should be_true
    Painter.new(cellmap1).send("brushable?", 3).should be_false
 
  end
 
  it "should paintable?" do
    cellmap1 = [[0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,1,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0]]
    Painter.new(cellmap1).send("paintable?", 0, 0, 2).should be_true
    Painter.new(cellmap1).send("paintable?", 0, 0, 3).should be_false
    Painter.new(cellmap1).send("paintable?", 1, 1, 1).should be_true
    Painter.new(cellmap1).send("paintable?", 1, 1, 2).should be_false
    Painter.new(cellmap1).send("paintable?", 0, 2, 2).should be_false
    Painter.new(cellmap1).send("paintable?", 4, 4, 2).should be_true
    Painter.new(cellmap1).send("paintable?", 4, 4, 3).should be_false
    cellmap2 = [[0,0,0,0,0,0],
                [0,0,0,0,0,0],
                [0,0,1,1,0,0],
                [0,0,1,1,0,0],
                [0,0,0,0,0,0],
                [0,0,0,0,0,0]]
    Painter.new(cellmap2).send("paintable?", 0, 0, 2).should be_true
    Painter.new(cellmap2).send("paintable?", 0, 0, 3).should be_false
  end
 
  it "should paint" do
    cellmap = [[0,0,0,0,0,0],
               [0,0,0,0,0,0],
               [0,1,0,0,0,0],
               [0,0,0,0,0,0],
               [0,0,0,0,0,0],
               [0,0,0,0,0,0]]
    painted_map = [[0,0,0,0,0,0],
                   [0,0,0,0,0,0],
                   [0,0,0,0,0,0],
                   [0,0,0,0,0,0],
                   [0,0,0,0,0,0],
                   [0,0,0,0,0,0]]
    Painter.new(cellmap).send("paint", painted_map, 0, 0, 2)
    0.upto(1) do |y|
      0.upto(1) do |x|
        painted_map[y][x].should == 1
      end
    end
 
    Painter.new(cellmap).send("paint", painted_map, 5, 5, 2)
    painted_map[5][5].should == 0
  end
end
