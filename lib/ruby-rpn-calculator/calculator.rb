class RubyRPNCalculator
  class Calculator
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def run
      return if @config['run-modes'].include?(:skip_execution)

      case @config['input-type']
      when :CLI then take_input_loop
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

    def take_input_loop
      take_input while !done_taking_input?
    end

    def take_input
      render_results unless @config['run-modes'].include?(:quiet)

      print('> ') unless @config['run-modes'].include?(:quiet)

      input = @config['validator'].validate_input($stdin.gets.chomp)

      @state['all-inputs'] << input

      return if input == 'q'

      insert_input_into_heap(input)
    end

    def insert_input_into_heap(input)
      #TBI
    end

    # [TODO] handle end of file
    def done_taking_input?
      return true if @state['all-inputs'].last == 'q'

      false
    end
  end
end
