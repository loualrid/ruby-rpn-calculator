## Ruby RPN Calculator

## Features

* Do calculations with `+, -, *, /`

## Configuration

### Initial Setup (RVM)

Assuming RVM is installed, cd to the root of the project and run `bundle install` (you will need to install ruby-2.4.1 if you don't have it already)

### Initial Setup (others)

This project was setup on ruby-2.4.1 but can be run on any ruby greater than 1.9.1, when the configuration is set, just run `bundle install`.

### Running the Calculator

To run the calculator, `bundle exec rrc`. `bundle exec rrpnc` or `bundle exec ruby-rpn-calculator` also work.

### Running the tests

The tests are standard rspec, nothing special:

```
bundle exec rspec
```
