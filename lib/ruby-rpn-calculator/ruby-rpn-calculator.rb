require 'terminal-table'
require 'terminal-table/import'
require 'active_support'
require 'active_support/core_ext'

Dir["#{File.dirname(__FILE__)}/../**/*.rb"].each { |f| require f }

class RubyRPNCalculator
  def initialize(config = {}, state = {})
    @config = config
    @state  = state

    @config['start-time']           = Time.now
    @config['run-modes']          ||= []
    @config['input-type']           = nil
    @config['helper']               = Helper.new(@config, @state)
    @config['validator']            = Validator.new(@config, @state)
    @config['calculator']           = Calculator.new(@config, @state)
    @config['processor']            = Processor.new(@config, @state) #stack manager

    @state['input-stack']      = []
    @state['all-inputs']       = []
    @state['all-valid-inputs'] = []

    @config['initializer'] = Initializer.new(@config, @state)

    @config['validator'].validate_configuration

    @config['calculator'].run
  end

  def dump_config
    @config['helper'].dump_config
  end

  def dump_state
    @config['helper'].dump_state
  end

  def render_results
    @config['calculator'].render_results
  end
end
