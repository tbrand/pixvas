module Pixvas
  class Color
    COLORS = [
      :black,
      :white,
      :red,
      :light_red,
      :green,
      :light_green,
      :yellow,
      :light_yellow,
      :blue,
      :light_blue,
      :cyan,
      :light_cyan,
      :magenta,
    ]
    
    @@instance : Color = self.new

    def self.get_instance : Color
      @@instance
    end

    getter bg_color : Symbol? = nil

    def initialize
      @current_color_idx = 0
    end

    def next
      @current_color_idx += 1
    end

    def set_bg
      @bg_color = current_color
    end

    def current_color : Symbol
      COLORS[@current_color_idx % COLORS.size]
    end

    def draw_panel
      print "\n "

      COLORS.each do |color|
        print " ".colorize.back(color)
      end

      print " \n "

      COLORS.each do |color|
        next print "▲" if current_color == color
        print " "
      end
    end
  end
end
