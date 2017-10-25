module Pixvas
  class Color < Component
    COLOR_MAP = {
      black: "#000",
      white: "#FFF",
      red: "#F00",
      light_red: "#F22",
      green: "#0F0",
      light_green: "#2f2",
      yellow: "#FF0",
      light_yellow: "#FF2",
      blue: "#00F",
      light_blue: "#22F",
      cyan: "#0FF",
      light_cyan: "#2FF",
      magenta: "#A00",
    }

    getter bg_color : Symbol? = nil

    def initialize
      super
      @current_color_idx = 0
    end

    def next
      @current_color_idx += 1
    end

    def set_bg
      @bg_color = current_color
    end

    def colors
      COLOR_MAP.keys
    end

    def hex(color : Symbol) : String
      COLOR_MAP[color]
    end

    def current_color : Symbol
      colors[@current_color_idx % colors.size]
    end

    def draw_panel
      print "\n "

      colors.each do |color|
        print " ".colorize.back(color)
      end

      print " \n "

      colors.each do |color|
        next print "▲" if current_color == color
        print " "
      end
    end
  end
end
