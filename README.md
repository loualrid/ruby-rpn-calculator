## Ruby RPN Calculator

## Features

* Do calculations with `+, -, *, /, %`
* Uses terminal-table to output result, stack, and operations neatly
* Supports configuration options to turn off table and use non-fancy output (only shows latest result)

## Architectural Decisions

The classes are structured as such to improve maintainability and show a clear flow

1. Start program
2. Run initializer
    1. Set options from initialization (CLI arguments / etc)
    2. Initialize configuration options
3. Validate configuration options
    1. [NYI] Check to ensure the file passed in for the -f argument exists and IS VALID
4. Run the calculator
    1. Check the type input the calculator has been set up to accept and change runtime from there
        1. For input type of CLI (only supported type)
            1. Start an input loop
            2. Validate the input coming in from the command line
            3. Process the stack of operands and operators
            4. Display the result of processing the stack
            5. Continue to wait for input or break with `q / CTRL+D`

The initialization of class variables received from the initial state is to facilitate development on the program, a final version for production could be refactored to remove these.

## Trade-offs
More time spent on the program would result in refactoring and adding the other input types. I am satisfied with the CLI interface from a user perspective though.

It would not be overly difficult to support notation like `5 8 +` on a single line but I opted for one main input per line to make it easier to validate. This has the amusing affect of making inputs like `52 1 62 +` be processed correctly (or incorrectly?) as 52 for that input.

## Configuration

### Initial Setup (RVM)

Assuming RVM is installed, cd to the root of the project and run `bundle install` (you will need to install ruby-2.4.1 if you don't have it already)

### Initial Setup (others)

This project was setup on ruby-2.4.1 but can be run on any ruby greater than 1.9.1, when the configuration is set, just run `bundle install`.

### Running the Calculator

To run the calculator, `bundle exec rrc`. `bundle exec rrpnc` or `bundle exec ruby-rpn-calculator` also work.

The help menu for different options can be seen with `bundle exec rrc -h`

### Running the tests

The tests are standard rspec, nothing special:

```
bundle exec rspec
```
