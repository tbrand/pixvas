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
    end

    def message : String
      @message ||
        "Welcome to Pixvas!".colorize.fore(context.color.current_color).mode(:bold).to_s
    end

    def set_command(@mode : Int32, @message : String)
    end

    def exec_command
      case @mode
      when Type::EXPORT
        filepath = File.expand_path("../../../../out/test.svg", __FILE__)
        file = File.open(filepath, "w")
        file.puts context.svg.export
        file.close

        @message = "The image has been saved as test.svg"
      end

      true
    end

    def draw_panel
      puts message
      puts "> "
    end
  end
end
