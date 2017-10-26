module Pixvas
  class Command < Component
    module Type
      NONE = 0
      EXPORT = 1
    end

    getter mode

    def initialize
      super
      @mode = Type::NONE
      @command_line = [] of Char
    end

    def message : String
      case @mode
      when Type::EXPORT
        return "Export as ([Input].svg) | Enter to export, Ctr-g to cancel"
      end

      if message = @hint_message
        @hint_message = nil
        return message
      end

      "Welcome to Pixvas!".colorize.fore(context.color.current_color).mode(:bold).to_s
    end

    def add_char(idx : Int32, c)
      @command_line.insert(idx, c)
    end

    def rm_char(idx : Int32)
      @command_line.delete_at(idx)
    end

    def set_command(@mode : Int32)
    end

    def exec_command
      case @mode
      when Type::EXPORT
        filepath = File.expand_path("../../../../out/#{command}.svg", __FILE__)
        file = File.open(filepath, "w")
        file.puts context.svg.export
        file.close

        @hint_message = "The image has been saved as #{command}.svg"
      end

      @command_line.clear
      @mode = Type::NONE

      true
    end

    def command : String
      @command_line.join("")
    end

    def draw_panel
      puts message
      puts "> " + command
    end
  end
end
