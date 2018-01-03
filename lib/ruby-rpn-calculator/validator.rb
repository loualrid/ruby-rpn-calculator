class RubyRPNCalculator
  class Validator
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def input_error(specific_error)
      puts(
        "What you entered contains #{specific_error}, we'll ask for a valid " \
        "input again so please use a numeric value or +, -, * or / " \
      ) unless @config['run-modes'].include?(:quiet)

      validate_input($stdin.gets.chomp)
    end

    # [TODO] leaving this in just in case there's a scenario where parsing the
    # configuration would be useful, right now it's all set without user input
    def validate_configuration
      return if @config['run-modes'].include?(:skip_validation)

      # validate_input_type
    end

    def validate_input(input)
      input = input_error('nothing') if input.blank?
      input = input_error('letters') if !input.scan(/[a-pr-zA-Z]/).empty?

      input
    end
  end
end
