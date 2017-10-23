module Pixvas
  abstract class Export
    def initialize
      @color = Color.get_instance
    end

    abstract def export(width : Int32, height : Int32, dot_width : Int32, cursor : Cursor)
  end
end
