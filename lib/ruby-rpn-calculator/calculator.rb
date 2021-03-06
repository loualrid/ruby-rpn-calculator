# frozen_string_literal: true

class RubyRPNCalculator
  class Calculator
    def initialize(config, state)
      @config = config
      @state  = state
    end

    def run
      return if @config['run-modes'].include?(:skip_execution)

      case @config['input-type']
      when :CLI       then take_input_loop
      when :file      then raise "Unsupported Input Type"
      when :websocket then raise "Unsupported Input Type"
      when :tcpsocket then raise "Unsupported Input Type"
      end
    end

    def render_results
      results = Terminal::Table.new do |table|
        table.add_row @state['all-valid-inputs']
        table.add_row :separator unless @state['results-for-table'].empty?

        @state['results-for-table'].each do |row|
          table_length = @state['all-valid-inputs'].length

          table.add_row :separator if row == @state['results-for-table'].last

          # ensure the results table is always the right length
          table.add_row row.insert(-1, *Array.new(table_length - row.length))
        end
      end

      puts("#{results}\n\n") unless @config['run-modes'].include?(:quiet)

      results
    end

    def supported_operators
      %w(+ - / * %)
    end

    private

    def take_input_loop
      take_input while !done_taking_input?
    end

    def take_input
      print('> ') unless @config['run-modes'].include?(:quiet)

      begin
        input = @config['validator'].validate_input($stdin.gets.chomp)
      rescue NoMethodError
        # Handle the EOF / CTRL+D case
        @state['all-inputs'] << 'q'
        input = 'q'
      end

      return if input == 'q'

      @state['all-valid-inputs'] << input

      current_result = @config['processor'].process_input(input)

      return if @config['run-modes'].include?(:quiet)

      if @config['run-modes'].include?(:no_table)
        puts current_result
      else
        render_results
      end
    end

    # [TODO] handle end of file
    def done_taking_input?
      return true if @state['all-inputs'].last == 'q'

      false
    end
  end
end
