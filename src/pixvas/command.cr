module Pixvas
  class Command
    @@instance : Command = self.new

    def self.get_instance : Command
      @@instance
    end

    module Type
      NONE = 0
      EXPORT = 1
    end

    getter mode

    def initialize
      @color = Color.get_instance
      @mode = Type::NONE
    end

    def message : String
      @message ||
        "Welcome to Pixvas!".colorize.fore(@color.current_color).mode(:bold).to_s
    end

    def set_command(@command_type : Int32, @message : String)
    end

    def delete_message
      @message = nil
    end

    def draw_panel
      puts message
      puts "> "
    end
  end
end
