require 'spec_helper'

describe RubyRPNCalculator::Validator, type: :initialization do
  describe "invalid input", type: :calc do
    it "should not let the client input gibberish" do
      initialize_and_run_calc_with_inputs(%w(C B + q))

      expect( @rrpnc.dump_state['input-stack'] ).to be == []
      expect( @rrpnc.dump_state['all-valid-inputs'] ).to be == %w(q q q)
    end

    it "should not let the number of operators exceed the number of numbers" do
      initialize_and_run_calc_with_inputs(%w(1 2 3 + - - q))

      expect( @rrpnc.dump_state['input-stack'] ).to be == %w(-4.0)
      expect( @rrpnc.dump_state['all-inputs'] ).to be == %w(1 2 3 + - - q)
      expect( @rrpnc.dump_state['all-valid-inputs'] ).to be == %w(1 2 3 + - q)
    end
  end
end
