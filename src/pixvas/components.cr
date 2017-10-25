module Pixvas
  abstract class Component
    def initialize
    end

    def set_context(@_context : Context)
    end

    def context : Context
      @_context.not_nil!
    end
  end
end

require "./components/*"
