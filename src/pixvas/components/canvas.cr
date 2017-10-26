require "colorize"

module Pixvas
  class Canvas < Component
    DOT_WIDTH = 2

    def initialize
      dot_count_x = 10
      dot_count_y = 10

      super(3, 3, dot_count_x * DOT_WIDTH + 2, dot_count_y + 2)

      @dot_size = 2
      @colors = Array(Array(Int32)).new

      dot_count_x.times do |x_idx|
        @colors.push(Array(Int32).new)

        dot_count_y.times do |y_idx|
          @colors[x_idx].push(0)
        end
      end
    end

    def refresh
      @window.move(@cy, @cx)
      @window.refresh
    end

    def pin
      @colors[@cx][@cy] = -1
      dot = Crt::ColorPair.new(Crt::Color::Default, Crt::Color::Red)
      @window.attribute_on dot
      @window.print(@cy, @cx, " " * DOT_WIDTH)
    end

    def wait
      refresh

      while c = STDIN.raw &.read_char
        exit if c.ord == 3 # Ctr-c

        # if 97 <= c.ord && c.ord <= 122
        #   @window.print(@cy, @cx, c.to_s)
        #   @cx += 1
        # end

        case c.ord
        when 16
          up
        when 14
          down
        when 2
          left
        when 6
          right
        when 32
          pin
        end

        refresh
      end
    end
  end
end
