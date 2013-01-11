file_content = open(ARGV[0]).read

class Cell
  attr_accessor :painted, :is_window

  def initialize(content)
    @is_window = content == "1"
    @painted = false
  end
end

door = []

file_content.split(/\n/).each_with_index do |line, i|
  line.split(//).each_with_index do |content, j|
    door[i] ||= []
    door[i][j] = Cell.new(content)
  end
end

door_size = door.length
brush_size = 2
door.each_with_index do |col, i|
  col.each_with_index do |cell, j|
    paintable = true
    catch(:paintable) do
      (0...brush_size).each do |k|
        (0...brush_size).each do |l|
          if door[i+k].nil? || door[i+k][j+l].nil?
            next
          end
          if door[i+k][j+l].is_window
            paintable = false
            throw :paintable
          end
        end
      end
    end
    p paintable
  end
end

#  if paintable

