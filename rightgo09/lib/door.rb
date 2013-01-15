# -*- encoding: utf-8 -*-

class Door
  attr_reader :size, :cells

  def initialize(lines)
    @cells = []
    #
    #           分                解
    #
    lines.split(/\n/).each_with_index do |line, i|
      @cells[i] = []
      line.split(//).each do |cell|
        @cells[i].push Cell.new(cell)
      end
    end
    #
    # 正方形チェック
    #
    raise "please input square" unless square? @cells
    @size = @cells.size
  end

  def square?(cells)
    each_x = cells.map { |cell| cell.size }
    y = cells.size
    each_x.each do |x|
      return false unless x == y
    end
    true
  end

  def white_cell
    @cells.each { |line| line.each { |cell| cell.painted = false } }
  end

  class Cell
    attr_accessor :is_window, :painted

    def initialize(cell)
      @is_window = cell == '1'
    end

    def window?  ; @is_window; end
    def painted? ; @painted  ; end
  end
end

