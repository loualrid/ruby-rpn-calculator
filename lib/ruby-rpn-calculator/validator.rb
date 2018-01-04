# frozen_string_literal: true
class RubyRPNCalculator
  class Validator
    def initialize(config, state)
      @config = config
      @state  = state
    end

    # [TODO] leaving this in just in case there's a scenario where parsing the
    # configuration would be useful, right now it's all set without user input
    def validate_configuration
      return if @config['run-modes'].include?(:skip_validation)

      # validate_input_type
    end

    def validate_input(input)
      @state['all-inputs'] << input

      return input if check_run_modes_to_escape_validation_loop?

      input = input_error('nothing') if input.blank?
      input = input_error('letters') if !input.scan(/[a-pr-zA-Z]/).empty?
      input = input_error('operator with no preceding numbers') if !validated_operator_on_stack?(input)

      if input.scan(/[\d|q|#{@config['calculator'].supported_operators.join('|\\')}]/).empty?
        input = input_error('not a number or an operator')
      end

      input
    end

    private

    def input_error(specific_error)
      puts(
        "What you entered contains #{specific_error}, we'll ask for a valid " \
        "input again so please use a numeric value or " \
        "#{@config['calculator'].supported_operators.to_sentence}.\nIf you " \
        "wish to quit, please enter q."
      ) unless @config['run-modes'].include?(:quiet)

      validate_input($stdin.gets.chomp)
    end

    def validated_operator_on_stack?(input)
      return true if input =~ /[\d|q]/

      return false if @state['input-stack'].empty? && @config['calculator'].supported_operators.include?(input)

      return false if !valid_to_insert_operator_on_stack?(input)

      true
    end

    def valid_to_insert_operator_on_stack?(input)
      @state['input-stack'].count { |i| i =~ /\d/ } >
        (@state['input-stack'].count { |i| @config['calculator'].supported_operators.include?(i) } + 1)
    end

    def check_run_modes_to_escape_validation_loop?
      if @config['run-modes'].include?(:prevent_validation_loop)
        @state['all-inputs'].last == 'q' && @state['all-inputs'].length > 1
      end
    end
  end
end
