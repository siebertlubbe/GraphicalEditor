# The dispatcher class receives all input and dispatches it to the implemented
# commands
class Dispatcher
  require File.dirname(__FILE__) + '/interpreter/commands.rb'
  include Commands

  attr_reader :canvas

  # execute is the main entry point into the dispacher. it handles all input
  def execute(input_string)
    input = Input.new(input_string)

    send "#{input.command.downcase}_command".to_sym, input.args
  end

end

# The input class parses an input string into command and arguments.
# It also does a little validation
class Input
  require File.dirname(__FILE__) + '/validations/input_validations.rb'
  include InputValidations

  attr_reader :args, :command

  def initialize(input)
    @args = input.split(' ')
    @command = @args.shift
    validate_command_value!(@command)
  end

end