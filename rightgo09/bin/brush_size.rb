require_relative '../lib/door'
require_relative '../lib/brush'

door = Door.new(STDIN.read)
brush = Brush.new(door)

puts brush.size
