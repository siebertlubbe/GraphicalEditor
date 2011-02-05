# The InputValidations module wraps all the validation methods required by the
# Input class
module InputValidations

  def validate_command_value!(value)
    raise GraphicEditorError.new "Command must be a single capital letter" unless value =~ /^[A-Z]$/
    return true
  end

end