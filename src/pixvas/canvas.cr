require "colorize"
require "../pixvas/cursor"

module Pixvas
  class Canvas
    def initialize(@width : Int32, @height : Int32, @dot_width : Int32)
      @command = Command.get_instance
      @color  = Color.get_instance
      @cursor = Cursor.new(@width, @height, @dot_width)
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

    def draw_canvas
      puts "+" + ("-" * @width * @dot_width) + "+"

      @height.times do |h|
        print "|"

        (@width).times do |w|
          pin(w, h)
        end

        puts "|"
      end

      puts "+" + ("-" * @width * @dot_width) + "+"      
    end

    def draw
      @cursor.save
      @cursor.hide
      @cursor.reset
      @command.draw_panel
      draw_canvas
      @color.draw_panel
      @cursor.restore
      @cursor.show
    end
  end
end
