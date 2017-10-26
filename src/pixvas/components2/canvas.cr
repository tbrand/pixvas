require "colorize"

module Pixvas
  class Canvas < Component
    def dot : String
      " " * context.dot_width
    end

    def pin(x : Int32, y : Int32)
      if color = context.cursor.pinned?(x, y)
        # print dot.colorize.back(color)
        context.window.print(x, y, dot.colorize.back(color))
        return
      end

      if color = context.color.bg_color
        # print dot.colorize.back(color)
        context.window.print(x, y, dot.colorize.back(color))
        return
      end

      # print dot
    end

    def wait
      context.cursor.clear
      context.cursor.reset

      draw

      context.cursor.canvas_inside

      while context.cursor.wait
        draw
      end
    end

    def draw_canvas
      puts "+" + ("-" * context.width * context.dot_width) + "+"
      context.height.times do |h|
        print "|"
        (context.width).times do |w|
          pin(w, h)
        end
        puts "|"
      end
      puts "+" + ("-" * context.width * context.dot_width) + "+"
    end

    def draw
      context.cursor.save
      context.cursor.hide
      context.cursor.reset
      context.cursor.clear
      context.command.draw_panel

      draw_canvas

      context.color.draw_panel
      context.cursor.restore
      context.cursor.show
    end
  end
end
