# coding: utf-8

class Door
  def initialize(filepath)
    lines = File.read(filepath).split("\n")
    @size = lines.size
    @panels = lines.each_with_index.map { |item, i| item.split(//) }
  end

  def panel(h, w)
    raise StandardError if h < 0 || w < 0 || h >= @size || w >= @size
    @panels[h][w]
  end

  # 縦横それぞれの列の、brush_size_for_lineの最小値がbrush_size
  def brush_size
    (
      @size.times.map { |h| brush_size_for_line(horizonal_line(h)) } +
      @size.times.map { |v| brush_size_for_line(vartical_line(v)) }
    ).compact.min
  end

private
  # 横一列を配列で返す
  def horizonal_line(h)
    @panels[h]
  end

  # 縦一列を配列で返す
  def vartical_line(h)
    @panels.map { |line| line[h] }
  end

  # 0と1からなるpanelの配列を引数に取り、0の連なりの最小値を返す
  # brush_size_for_line(["0", "0", "0"]) => 3
  # brush_size_for_line(["0", "1", "0"]) => 1
  # brush_size_for_line(["1", "0", "0"]) => 2
  # brush_size_for_line(["1", "1", "1"]) => nil # 0ではない
  def brush_size_for_line(line)
    line.join.split("1").delete_if { |item| item == "" }.map { |item| item.size }.min
  end
end
