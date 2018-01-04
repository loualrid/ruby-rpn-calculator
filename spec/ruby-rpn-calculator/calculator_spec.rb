require 'spec_helper'

describe RubyRPNCalculator::Calculator, type: :initialization do
  describe "valid run", type: :calc do
    it "should output 6 from 2, 4, and +" do
      initialize_and_run_calc_with_inputs(%w(2 4 + q))

      expect( @rrpnc.dump_state['input-stack'] ).to be == %w(6)
      expect( @rrpnc.dump_state['all-valid-inputs'] ).to be == %w(2 4 +)
    end
  end
end
