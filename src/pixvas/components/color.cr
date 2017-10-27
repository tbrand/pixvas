module Pixvas
  class Color < Component

    COLORS = [
      Crt::Color::Black,
      Crt::Color::Red,
      Crt::Color::Green,
      Crt::Color::Yellow,
      Crt::Color::Blue,
      Crt::Color::Magenta,
      Crt::Color::Cyan,
      Crt::Color::White,
    ]

    @current_color_idx = 0

    def initialize
      super(23, 0, 6, COLORS.size + 2)
      print_color_list
    end

    def print_color_list
      color_cursor = Crt::ColorPair.new(current, Crt::Color::Default)
      color_none = Crt::ColorPair.new(Crt::Color::Default, Crt::Color::Default)

      COLORS.each_with_index do |color, i|
        color_pair = Crt::ColorPair.new(Crt::Color::Default, color)

        @window.attribute_on color_pair
        @window.print(i+1, 1, " " * DOT_WIDTH)
        @window.attribute_off color_pair

        if i == @current_color_idx % COLORS.size
          @window.attribute_on color_cursor
          @window.print(i+1, DOT_WIDTH + 1, " <")
          @window.attribute_off color_cursor
        else
          @window.attribute_on color_none
          @window.print(i+1, DOT_WIDTH + 1, "  ")
          @window.attribute_off color_none
        end
      end

      @window.refresh
    end

    def current : Crt::Color
      COLORS[@current_color_idx % COLORS.size]
    end

    def next
      @current_color_idx += 1
      print_color_list
    end
  end
end
