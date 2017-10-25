module Pixvas
  class Svg < Component
    UNIT_WIDTH  = 5
    UNIT_HEIGHT = 10

    def rect(x : Int32, y : Int32, dot_width : Int32) : String
      _x = UNIT_WIDTH * dot_width * x
      _y = UNIT_HEIGHT * y

      if color = context.cursor.pinned?(x, y)
        return "<rect x=\"#{_x}\" y=\"#{_y}\" width=\"#{UNIT_WIDTH * dot_width}\" height=\"#{UNIT_HEIGHT}\" fill=\"#{context.color.hex(color)}\"/>"
      end

      ""
    end

    def bg_rect(width, height) : String
      if color = context.color.bg_color
        return "<rect x=\"0\" y=\"0\" width=\"#{width}\" height=\"#{height}\" fill=\"#{context.color.hex(color)}\"/>"
      end

      ""
    end

    def export
      svg_width = context.width * context.dot_width * UNIT_WIDTH
      svg_height = context.height * UNIT_HEIGHT

      hd = "<?xml version=\"1.0\" standalone=\"no\"?>"
      tg = "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">"
      ts = "<svg width=\"10cm\" height=\"10cm\" viewBox=\"0 0 #{svg_width} #{svg_height}\" xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">"
      te = "</svg>"

      rects = ""

      context.height.times do |h|
        context.width.times do |w|
          rects += rect(w, h, context.dot_width)
        end
      end

      hd + tg + ts + bg_rect(svg_width, svg_height) + rects + te
    end
  end
end
