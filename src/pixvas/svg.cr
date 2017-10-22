module Pixvas

  class Svg
    UNIT_WIDTH  = 10
    UNIT_HEIGHT = 20

    def initialize
      @color = Pixvas::Color.get_instance
    end

    # memo: http://www.h2.dion.ne.jp/~defghi/svgMemo/svgMemo_05.htm

    def rect(x : Int32, y : Int32, dot_width : Int32, cursor : Pixvas::Cursor)
      _x = UNIT_WIDTH * dot_width * x
      _y = UNIT_HEIGHT * y

      if color = cursor.pinned?(x, y)
        return "<rect x=\"#{_x}\" y=\"#{_y}\" width=\"#{UNIT_WIDTH * dot_width}\" height=\"#{UNIT_HEIGHT}\" fill=\"red\"/>"
      end

      if color = @color.bg_color
        return "<rect x=\"#{_x}\" y=\"#{_y}\" width=\"#{UNIT_WIDTH * dot_width}\" height=\"#{UNIT_HEIGHT}\" fill=\"blue\"/>"
      end

      ""
    end

    def export(width, height, dot_width, cursor : Pixvas::Cursor)
      svg_width = width * dot_width * UNIT_WIDTH
      svg_height = height * UNIT_HEIGHT

      hd = "<?xml version=\"1.0\" standalone=\"no\"?>"
      tg = "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">"
      ts = "<svg width=\"10cm\" height=\"10cm\" viewBox=\"0 0 #{svg_width} #{svg_height}\" xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">"
      te = "</svg>"

      rects = ""

      height.times do |h|
        width.times do |w|
          rects += rect(w, h, dot_width, cursor)
        end
      end

      hd + tg + ts + rects + te
    end
  end
end
