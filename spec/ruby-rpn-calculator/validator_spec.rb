require 'spec_helper'

describe RubyRPNCalculator::Validator, type: :initialization do
  describe "invalid input", type: :calc do
    it "should not let the client input gibberish" do
      initialize_and_run_calc_with_inputs(%w(C B + q))

      expect( @rrpnc.dump_state['input-heap'] ).to be == []
    end
  end
end
