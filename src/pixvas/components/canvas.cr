module Pixvas
  class Canvas < Component
    def initialize
      dot_count_x = 10
      dot_count_y = 10
      @colors = Hash(String, Crt::Color).new

      super(0, 0, dot_count_x * DOT_WIDTH + 2, dot_count_y + 2)
    end

    def refresh
      @window.move(@cy, @cx)
      @window.refresh
    end

    def up
      return unless @cy > 1
      @cy -= 1
    end

    def down
      return unless @cy < @h - 2
      @cy += 1
    end

    def left
      return unless @cx > 2
      @cx -= 2
    end

    def right
      return unless @cx < @w - 3
      @cx += 2
    end

    def pin
      dot_color = Crt::ColorPair.new(Crt::Color::Default, context.color.current)

      @window.attribute_on dot_color
      @window.print(@cy, DOT_WIDTH * ((@cx-1)/DOT_WIDTH) + 1, " " * DOT_WIDTH)
      @window.attribute_off dot_color

      @colors["#{@cx}:#{@cy}"] = context.color.current
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
        when 99
          context.color.next
        end

        refresh
      end
    end
  end
end
