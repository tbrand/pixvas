module Pixvas
  class Cursor < Component

    module Mode
      CANVAS = 0
      COMMAND = 1
    end

    def initialize
      super

      @x = 0
      @y = 0
      @mode = Mode::CANVAS
      @colors = Hash(String, Symbol?).new
    end

    def mode_command : Bool
      return false if @mode == Mode::COMMAND
      @mode = Mode::COMMAND
      position(3, 2)
      true
    end

    def mode_canvas : Bool
      return false if @mode == Mode::CANVAS
      clear
      @mode = Mode::CANVAS
      position(@x + 2, @y + 4)
      true
    end

    def up : Bool
      return false if @mode == Mode::COMMAND
      return true unless @y > 0
      @y -= 1
      print "\e[A"
      true
    end

    def down : Bool
      return false if @mode == Mode::COMMAND
      return true unless @y < context.height - 1
      @y += 1
      print "\e[B"
      true
    end

    def forward : Bool
      return false if @mode == Mode::COMMAND
      return true unless @x < context.width * context.dot_width - 1
      @x += 1
      print "\e[C"
      true
    end

    def back : Bool
      return false if @mode == Mode::COMMAND
      return true unless @x > 0
      @x -= 1
      print "\e[D"
      true
    end

    def next_color : Bool
      return false if @mode == Mode::COMMAND
      context.color.next
      true
    end

    def set_bg : Bool
      return false if @mode == Mode::COMMAND
      context.color.set_bg
      true
    end

    def pin : Bool
      return false if @mode == Mode::COMMAND
      @colors["#{@x/context.dot_width}:#{@y}"] = context.color.current_color
      true
    end

    def delete : Bool
      return false if @mode == Mode::COMMAND
      @colors["#{@x/context.dot_width}:#{@y}"] = nil
      true
    end

    def cancel : Bool
      mode_canvas
    end

    def enter : Bool
      mode_canvas
      context.command.exec_command
    end

    def export : Bool
      return false if @mode == Mode::COMMAND
      context.command.set_command(
        Command::Type::EXPORT,
        "Export as ([Input].svg) | Enter to export, Ctr-g to cancel")
      mode_command
    end

    def backspace : Bool
      return false if @mode == Mode::CANVAS
      true
    end

    def quit : Bool
      reset
      clear
      exit 0
      true
    end

    def reset
      position(1, 1)
    end

    def canvas_inside
      position(2, 4)
    end

    def position(x : Int32, y : Int32)
      print "\e[#{y};#{x}H"
    end

    def clear
      print "\e[2J"
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

    def delete_line
      print "\e[K"
    end

    def pinned?(x : Int32, y : Int32) : Symbol?
      @colors["#{x}:#{y}"]?
    end

    def input_char?(c) : Bool
      if @mode == Mode::CANVAS
        case c
        when 'p'
          return up
        when 'n'
          return down
        when 'f'
          return forward
        when 'b'
          return back
        when 'c'
          return next_color
        when 'g'
          return set_bg
        when 'd'
          return delete
        when 's'
          return export
        else
          return false
        end
      else
        print c
      end

      true
    end

    def input_code?(c) : Bool
      case c.ord
      when 32 # <Space>
        return pin
      when 3 # Ctr-c
        return quit
      when 16 # Ctr-p
        return up
      when 14 # Ctr-n
        return down
      when 6 # Ctr-f
        return forward
      when 2 # Ctr-b
        return back
      when 7 # Ctr-g
        return cancel
      when 13 # <Enter>
        return enter
      when 127 # <Backspace>
        return backspace
      else
        return false
      end

      true
    end

    def wait : Bool
      if c = STDIN.raw &.read_char
        return true if input_code?(c)
        return true if input_char?(c)

        print "Unknown code: #{c.ord}"
        return true
      end

      false
    end
  end
end
