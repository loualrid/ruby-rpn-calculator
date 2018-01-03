class RubyRPNCalculator
  class Initializer
    def initialize(config, state)
      @config = config
      @state  = state

      initialize_configuration unless @config['run-modes'].include?(:skip_configuration)
    end

    private

    def initialize_configuration
      resolve_input_type
    end

    def resolve_input_type
      return if @config['input-type'] && !@config['validating']

      @config['input-type'] = :file
      return if ARGV.length > 0

      @config['input-type'] = :CLI
    end
  end
end
