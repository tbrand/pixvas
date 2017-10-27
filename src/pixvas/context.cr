module Pixvas
  class Context
    # Properties
    getter width : Int32
    getter height : Int32
    getter dot_width : Int32

    # Components
    getter canvas : Canvas
    getter color : Color
    # getter command : Command
    # getter cursor : Cursor
    # getter svg : Svg

    def initialize(@width : Int32, @height : Int32, @dot_width : Int32)
      @canvas = Canvas.new
      @color = Color.new
      # @command = Command.new
      # @cursor = Cursor.new
      # @svg = Svg.new
    end

    def run
      @canvas.set_context(self)
      @color.set_context(self)
      # @command.set_context(self)
      # @cursor.set_context(self)
      # @svg.set_context(self)
      #  
      @canvas.wait
    end
  end
end
