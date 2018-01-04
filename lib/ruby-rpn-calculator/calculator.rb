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

    def supported_operands
      %w(+ - / *)
    end

    private

    def take_input_loop
      take_input while !done_taking_input?
    end

    def take_input
      print('> ') unless @config['run-modes'].include?(:quiet)

      input = @config['validator'].validate_input($stdin.gets.chomp)

      return if input == 'q'

      @config['processor'].process_input(input)

      render_results unless @config['run-modes'].include?(:quiet)
    end

    # [TODO] handle end of file
    def done_taking_input?
      return true if @state['all-inputs'].last == 'q'

      false
    end
  end
end
