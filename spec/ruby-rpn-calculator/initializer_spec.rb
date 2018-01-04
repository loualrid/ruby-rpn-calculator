# frozen_string_literal: true

require 'spec_helper'

describe RubyRPNCalculator::Initializer, type: :initialization do
  describe "#initialize_configuration" do
    before do
      @modes = [:skip_validation, :skip_execution]
    end

    it "should default input-type to CLI if no ARGS are given to the program" do
      initialize_and_set_stdin_to([], @modes)

      expect( @rrpnc.dump_config['input-type'] ).to be == :CLI
    end
  end
end
