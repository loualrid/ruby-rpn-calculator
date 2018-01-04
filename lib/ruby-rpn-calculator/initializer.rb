# frozen_string_literal: true


require 'optparse'

class RubyRPNCalculator
  class Initializer
    def initialize(config, state)
      @config = config
      @state  = state

      initialize_arguments

      initialize_configuration unless @config['run-modes'].include?(:skip_configuration)
    end

    private

    def initialize_arguments
      OptionParser.new do |opts|
        opts.banner = "Usage: rrpnc [opts]"

        opts.on('-s', '--standard', 'Changes output type to standard, only displays the result') do
          @config['run-modes'] << :no_table
        end

        opts.on('-f', '--file FILEPATH', 'Changes input type to file and reads file from file path [NYI]') do |file|
          @config['input-type'] = :file
          @config['target-file'] = file
        end

        opts.on('-w', '--websocket', 'Changes input type to WebSocket and starts listening on port 8080 [NYI]') do
          @config['input-type'] = :websocket
        end

        opts.on('-t', '--tcpsocket', 'Changes input type to TCP Socket and starts listening on port 8081 [NYI]') do
          @config['input-type'] = :tcpsocket
        end

        opts.on('-h', '--help', 'Displays the available options') do
          puts opts

          exit
        end

        opts.on('-v', '--version', 'Displays the current version of the gem') do
          puts RubyRPNCalculator::VERSION

          exit
        end
      end.parse!
    end

    def initialize_configuration
      resolve_input_type
    end

    def resolve_input_type
      return if @config['input-type'] && !@config['validating']

      @config['input-type'] = :CLI
    end
  end
end
