require "colorize"
require "../pixvas/cursor"

module Pixvas
  class Canvas
    def initialize(@width : Int32, @height : Int32, @dot_width : Int32)
      @color  = Color.get_instance
      @cursor = Pixvas::Cursor.new(@width, @height, @dot_width)
    end

    def dot : String
      " " * @dot_width
    end

    def pin(x : Int32, y : Int32)
      if color = @cursor.pinned?(x, y)
        print dot.colorize.back(color)
        return
      end

      if color = @color.bg_color
        print dot.colorize.back(color)
        return
      end

      print dot
    end

    def wait
      @cursor.clear
      @cursor.reset

      draw
      @cursor.canvas_inside

      while @cursor.wait
        draw
      end
    end

    def draw
      @cursor.save
      @cursor.hide
      @cursor.reset

      title = "Welcome to Pixvas!".colorize.fore(@color.current_color).mode(:bold).to_s

      puts " >> #{title}"
      puts "+" + ("-" * @width * @dot_width) + "+"

      @height.times do |h|
        (@width + 2).times do |w|
          next print "|" if w == 0
          next print "|" if w == @width + 1

          pin(w-1, h)
        end

        puts ""
      end

      puts "+" + ("-" * @width * @dot_width) + "+"

      @color.draw_panel

      @cursor.restore
      @cursor.show
    end
  end
end
