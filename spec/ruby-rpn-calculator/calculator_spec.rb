require 'spec_helper'

describe RubyRPNCalculator::Calculator, type: :initialization do
  describe "valid run", type: :calc do
    it "should output 6 from 2, 4, and +" do
      initialize_and_run_calc_with_inputs(%w(2 4 + q))

      expect( @rrpnc.dump_state['input-stack'] ).to be == %w(6.0)
      expect( @rrpnc.dump_state['all-valid-inputs'] ).to be == %w(2 4 +)
    end

    it "should be able to handle a long string of inputs and output the correct result" do
      initialize_and_run_calc_with_inputs(%w(70 10 30 5 + - / 3 * 3 2 2 - - * q))

      expect( @rrpnc.dump_state['input-stack'] ).to be == %w(-25.199999999999996)
      expect( @rrpnc.dump_state['all-valid-inputs'] ).to be == %w(70 10 30 5 + - / 3 * 3 2 2 - - *)
    end

    it "should be able to process -3 -2 * 5 + into 11" do
      initialize_and_run_calc_with_inputs(%w(-3 -2 * 5 + q))

      expect( @rrpnc.dump_state['input-stack'] ).to be == %w(11.0)
      expect( @rrpnc.dump_state['all-valid-inputs'] ).to be == %w(-3 -2 * 5 +)
    end

    it "should be able to process 5 9 1 - / into 0.625" do
      initialize_and_run_calc_with_inputs(%w(5 9 1 - / q))

      expect( @rrpnc.dump_state['input-stack'] ).to be == %w(0.625)
      expect( @rrpnc.dump_state['all-valid-inputs'] ).to be == %w(5 9 1 - /)
    end
  end
end
