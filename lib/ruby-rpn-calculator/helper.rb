# frozen_string_literal: true
class RubyRPNCalculator
  class Helper
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def dump_config
      @config
    end

    def dump_state
      @state
    end
  end
end
