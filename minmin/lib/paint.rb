#!/usr/bin/env ruby

class Paint
  def initialize(door_str)
    @door = []
    door_str.split("\n").each do |line|
      @door << line.split("").map do |i|
        i.to_i
      end
    end
  end

  def min_length(arr)
    n = arr.size
    mins = []
    arr.each do |line|
      len = 0
      min = n
      i = 0
      while i < n do
        if line[i] == 1
          if len < min && len > 0
            min = len
            len = 0
          end
        else
          len += 1
        end
        i += 1
      end
      mins << min
    end
    return mins
  end

  def brash_size()
    n = @door.size
    i = 0
    pivot = []
    while i < n do
      pivot << @door.map do |line|
        line[i]
      end
      i += 1
    end
    (min_length(@door) + min_length(pivot)).min
  end
end
