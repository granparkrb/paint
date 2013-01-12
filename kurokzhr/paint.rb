# coding: utf-8
class Door
  def initialize(filepath)
    file = File.read(filepath)
    lines = file.split("\n")
    @panels = Array.new
    lines.each_with_index do |item, i|
      @panels[i] = item.split(//)
    end
    @size = @panels.size
  end

  def panel(h, w)
    return @panels[h][w]
  end

  def brush_size
    brush_size = @size
    @size.times do |h|
      @size.times do |w|
        if panel(h, w) == "1"
          aop = amount_of_panel(h, w)
          if brush_size > aop
            brush_size = aop
          end
        end
      end
    end
    return brush_size
  end

  def amount_of_panel(h, w)
    # XXX need refactoring
    # 上
    up = 0
    hh = h - 1
    ww = w
    while hh >= 0 && panel(hh, ww) == "0"
      up += 1
      hh -= 1
    end
    # 下
    down = 0
    hh = h + 1
    ww = w
    while hh < @size && panel(hh, ww) == "0"
      down += 1
      hh += 1
    end
    # 左
    left = 0
    hh = h
    ww = w - 1
    while ww >= 0 && panel(hh, ww) == "0"
      left += 1
      ww -= 1
    end
    # 右
    right = 0
    hh = h
    ww = w + 1
    while ww < @size && panel(hh, ww) == "0"
      right += 1
      ww += 1
    end
    return [up, down, left, right].delete_if {|item| item == 0}.min
  end
end

p Door.new("./data/quiz1.txt").brush_size
p Door.new("./data/quiz2.txt").brush_size
