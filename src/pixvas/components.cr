module Pixvas
  abstract class Component
    def initialize(@x : Int32, @y : Int32, @w : Int32, @h : Int32)
      @window = Crt::Window.new(@h, @w, @y, @x)
      @window.border('|', '|', '-', '-', '+', '+', '+', '+')
      @window.refresh
      LibNcursesw.curs_set(1)

      @cx = @cy = 1
    end

    def set_context(@_context : Context)
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
      return unless @cx > 1
      @cx -= 1
    end

    def right
      return unless @cx < @w - 2
      @cx += 1
    end

    def context : Context
      @_context.not_nil!
    end
  end
end

require "./components/*"
