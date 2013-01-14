# -*- encoding: utf-8 -*-

class Brush
  def initialize(door)
    @door = door
  end

  def size
    (1..@door.size).each do |brush_size|
      if paint?(brush_size)
        next
      else
        return brush_size - 1
      end
    end
    # Nothing window
    @door.size
  end

  def paint?(brush_size)
    # ドアのセルを白で塗り直しておく
    @door.white_cell

    #
    # 全セル走査
    # 基準となったセルからブラシサイズ分、右・下・右下のセルを確認
    # 窓が存在しなければOK
    # 全部塗りきってみて、塗れていないところがあれば
    # そのブラシサイズではこのドアは塗りきれない。
    #
    # 確認する基準のセルはブラシサイズ分このドアより小さくて済むのでループは
    # [0..(@door.size-brush_size)] になる
    #
    base_range = 0 .. (@door.size - brush_size)

    @door.cells[base_range].each_with_index do |line, i|
      line[base_range].each_with_index do |cell, j|
        # 基準セルが窓なら次のセルに即移動
        next if cell.window?

        can_paint = true

        catch(:can_paint) do
          (0 .. (brush_size - 1)).each do |y| # 下にブラシサイズ分進む
            (0 .. (brush_size - 1)).each do |x| # 右にブラシサイズ分進む
              if @door.cells[i + y][j + x].window?
                can_paint = false
                throw :can_paint
              end
            end
          end
        end
        if can_paint
          (0 .. (brush_size - 1)).each do |y| # 下にブラシサイズ分進む
            (0 .. (brush_size - 1)).each do |x| # 右にブラシサイズ分進む
              @door.cells[i + y][j + x].painted = true
            end
          end
        end
      end
    end

    # 塗れていないセルはあるか？
    @door.cells.each do |line|
      line.each do |cell|
        return false if (not cell.window?) && (not cell.painted?)
      end
    end

    true
  end
end
