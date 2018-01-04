require 'spec_helper'

describe RubyRPNCalculator::Calculator, type: [:initialization, :calc] do
  describe "valid run" do
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

  describe "#render_results" do
    before do
      initialize_and_run_calc_with_inputs(%w(5 9 1 - / q))
    end

    it "should be able to render the results table" do
      expect( @rrpnc.render_results ).to_not be_nil
    end

    it "should return a 'table' object" do
      expect( @rrpnc.render_results.class.to_s ).to be == 'Terminal::Table'
    end

    it "should render correctly for an input" do
      table_output =
        "+-------+---+-----+---+---+\n" \
        "| 5     | 9 | 1   | - | / |\n" \
        "+-------+---+-----+---+---+\n" \
        "| 9.0   | - | 1.0 |   |   |\n" \
        "| 8.0   |   |     |   |   |\n" \
        "| 5.0   | / | 8.0 |   |   |\n" \
        "+-------+---+-----+---+---+\n" \
        "| 0.625 |   |     |   |   |\n" \
        "+-------+---+-----+---+---+"

      expect( @rrpnc.render_results.to_s ).to eq table_output
    end
  end
end
