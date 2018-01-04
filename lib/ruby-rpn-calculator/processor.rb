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
        operand_two = @state['input-stack'].pop.to_f
        operand_one = @state['input-stack'].pop.to_f
        result = Math.class_eval("#{operand_one} #{token} #{operand_two}")
        @state['input-stack'].push(result.to_s)
      elsif !@config['calculator'].supported_operators.include?(token)
        @state['input-stack'] << token
      end

      @state['input-stack'].last
    end
  end
end
