class RubyRPNCalculator
  class Processor
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def process_input(input)
      process_stack(input)
    end

    private

    def process_stack(token)
      if @config['calculator'].supported_operators.include?(token)
        operand_two = @state['input-stack'].shift # pop from the start of the array
        operand_one = @state['input-stack'].shift
        result = Math.class_eval("#{operand_one} #{token} #{operand_two}")
        @state['input-stack'].insert(0, result.to_s)
      elsif !@config['calculator'].supported_operators.include?(token)
        @state['input-stack'] << token
      end

      @state['input-stack'].last
    end
  end
end
