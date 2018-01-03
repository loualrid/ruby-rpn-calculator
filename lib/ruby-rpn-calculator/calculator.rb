class RubyRPNCalculator
  class Calculator
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def run
      return if @config['run-modes'].include?(:skip_execution)

      case @config['input-type']
      when :CLI then take_input
      when :file then raise "Unsupported Input Type"
      end
    end

    def input_into_calculator(input)
      #TBI
    end

    def render_results
      #TBI
    end

    private

    def take_input
      #TBI
    end
  end
end
