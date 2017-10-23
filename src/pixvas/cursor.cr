module Pixvas
  class Cursor
    def initialize(@width : Int32, @height : Int32, @dot_width : Int32)
      @x = 0
      @y = 0

      @color  = Color.get_instance
      @colors = Hash(String, Symbol?).new
    end

    def clear
      print "\e[2J"
    end

    def reset
      position(1, 1)
    end

    def canvas_top_left
      position(2, 1)
    end

    def canvas_inside
      position(3, 2)
    end

    def position(x : Int32, y : Int32)
      print "\e[#{x};#{y}H"
    end

    def up
      return unless @y > 0
      @y -= 1
      print "\e[A"
    end

    def down
      return unless @y < @height - 1
      @y += 1
      print "\e[B"
    end

    def forward
      return unless @x < @width * @dot_width - 1
      @x += 1
      print "\e[C"
    end

    def back
      return unless @x > 0
      @x -= 1
      print "\e[D"
    end

    def save
      print "\e[s"
    end

    def restore
      print "\e[u"
    end

    def hide
      print "\e[?25l"
    end

    def show
      print "\e[?25h"
    end

    def next_color
      @color.next
    end

    def set_bg
      @color.set_bg
    end

    def pin
      @colors["#{@x/@dot_width}:#{@y}"] = @color.current_color
    end

    def delete
      @colors["#{@x/@dot_width}:#{@y}"] = nil
    end

    def pinned?(x : Int32, y : Int32) : Symbol?
      @colors["#{x}:#{y}"]?
    end

    def export
      file = File.new("./test.svg", "w")

      svg = Svg.new
      file.puts svg.export(@width, @height, @dot_width, self)
    end

    def quit
      reset
      clear
      exit 0
    end

    def input_char?(c) : Bool
      case c
      when 'p'
        up
      when 'n'
        down
      when 'f'
        forward
      when 'b'
        back
      when 'c'
        next_color
      when 'g'
        set_bg
      when 'd'
        delete
      when 's'
        export
      else
        return false
      end

      true
    end

    def input_code?(c) : Bool
      case c.ord
      when 32 # <Space>
        pin
      when 3 # Ctr-c
        quit
      when 16 # Ctr-p
        up
      when 14 # Ctr-n
        down
      when 6 # Ctr-f
        forward
      when 2 # Ctr-b
        back
      else
        return false
      end

      true
    end

    def wait : Bool
      if c = STDIN.raw &.read_char
        return true if input_char?(c)
        return true if input_code?(c)

        # print "Unknown code: #{c.ord}"
        return true
      end

      false
    end
  end
end
