class RubyRPNCalculator
  class Processor
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def process_input(input)
      insert_input_into_stack(input)

      process_stack
    end

    def input_into_calculator(input)
      #TBI
    end

    def render_results
      #TBI
    end

    private

    def insert_input_into_stack(input)
      @state['input-stack'] << input
    end

    def process_stack

    end
  end
end
