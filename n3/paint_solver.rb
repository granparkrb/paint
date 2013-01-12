#!/usr/bin/env ruby
# coding: utf-8

class PaintSolver
  attr_accessor :rows, :columns

  def initialize(door_str)
    @rows = door_str.lines.map(&:chomp)
    @columns = @rows.inject([]) do |columns, row|
      row.chars.each.with_index do |char, i|
        columns[i] ||= ''
        columns[i] << char
      end
      columns
    end
  end

  def solve
    min_row = @rows.first.size
    min_column = @columns.first.size

    @rows.each do |row|
      min_tmp = row.scan(/0+/).map(&:size).min
      min_row = [min_row, min_tmp].min
    end

    @columns.each do |column|
      min_tmp = column.scan(/0+/).map(&:size).min
      min_column = [min_column, min_tmp].min
    end

    [min_row, min_column].min
  end
end

s = 50.times.inject('') do |door_str, i|
  door_str << "0" * 50 + "\n"
end
s[-54] = '1'

ps = PaintSolver.new(s)
p ps.solve
