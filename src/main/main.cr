class Main
  def initialize
    @width = 20
    @height = 20
    @dot_width = 2
  end

  def parse_option!
    OptionParser.parse! do |parser|
      parser.banner = "Usage pixvas [options]"
      parser.on("-w WIDTH", "--width=WIDTH", "Canvas width") { |_width| @width = _width.to_i }
      parser.on("-h HEIGHT", "--height=HEIGHT", "Canvas height") { |_height| @height = _height.to_i }
      parser.on("-d DOT_WIDTH", "--dot=DOT_WIDTH", "Dot width") { |_dot_width| @dot_width = _dot_width.to_i }
      parser.on("-h", "--help", "Show this help") { show_help }
    end
  rescue
    puts "Found invalid option"
    show_help
  end

  def show_help
    puts "---- Welcome to Pixvas! ----"
    puts ""
    puts "Command options"
    puts "  --width=WIDTH   --- Set canvas width (-w for short)"
    puts "  --height=HEIGHT --- Set canvs height (-h for short)"
    puts "  --dot=DOT_WIDTH --- Set dot width (-d for short)"
    puts ""
    puts "Key bindings"
    puts "  <Space>    --- Print the color"
    puts "  p, n, f, b --- Move cursor: UP, DOWN, FORWARD, BACK"
    puts "  c          --- Change color"
    puts "  d          --- Delete the dot"
    puts "  g          --- Set background color"
    puts "  <Ctl-c>    --- Quit"
    puts ""
    exit 0
  end

  def run
    context = Pixvas::Context.new(@width, @height, @dot_width)
    context.run
  end
end

main = Main.new
main.parse_option!
main.run
