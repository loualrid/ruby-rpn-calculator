module InitializationSpecHelpers
  def initialize_and_set_stdin_to(string_array = [], run_modes_array = [])
    if string_array.length > 0
      allow($stdin).to receive(:gets).and_return(*string_array)
    end

    @rrpnc = RubyRPNCalculator.new( 'run-modes' => run_modes_array + [:quiet] )
  end
end

RSpec.configure do |config|
  config.include InitializationSpecHelpers, type: :initialization
end
