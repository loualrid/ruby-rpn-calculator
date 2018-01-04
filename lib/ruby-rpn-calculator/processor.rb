# frozen_string_literal: true
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

        process_results_for_table(operand_two, operand_one, token, result)

        @state['input-stack'].push(result.to_s)
      elsif !@config['calculator'].supported_operators.include?(token)
        @state['input-stack'] << token
      end

      @state['input-stack'].last
    end

    def process_results_for_table(operand_two, operand_one, token, result)
      @state['results-for-table'] << [operand_one, token, operand_two]
      @state['results-for-table'] << [result]
    end
  end
end
