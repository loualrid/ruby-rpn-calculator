module CalculatorSpecHelpers
  def initialize_and_run_calc_with_inputs(string_array = [])
    allow($stdin).to receive(:gets).and_return(*string_array)

    @rrpnc = RubyRPNCalculator.new( 'run-modes' => [:quiet] )
  end
end

RSpec.configure do |config|
  config.include CalculatorSpecHelpers, type: :calc
end
