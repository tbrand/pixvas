module Pixvas
  abstract class Component
    DOT_WIDTH = 2

    def initialize(@x : Int32, @y : Int32, @w : Int32, @h : Int32)
      @window = Crt::Window.new(@h, @w, @y, @x)
      @window.border('|', '|', '-', '-', '+', '+', '+', '+')
      @window.refresh
      LibNcursesw.curs_set(1)

      @cx = @cy = 1
    end

    def set_context(@_context : Context)
    end

    def context : Context
      @_context.not_nil!
    end
  end
end

require "./components/*"
