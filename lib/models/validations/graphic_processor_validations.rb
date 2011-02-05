# The GraphicProcessorValidations module wraps all the validation functions
# that is required by the Graphical Processor
module GraphicProcessorValidations

  def validate_x_coordinate_value!(value)
    raise GraphicEditorError.new "Value must be an interger"               unless value.to_i.to_s == value.to_s
    raise GraphicEditorError.new "Value must be bigger or equal to 1"      unless value.to_i >= 1
    raise GraphicEditorError.new "Value must be smaller or equal to 250"   unless value.to_i <= 250
    raise GraphicEditorError.new "Value must fit inside canvas dimensions" unless @canvas.empty? || value.to_i <= @width
    return true
  end

  def validate_y_coordinate_value!(value)
    raise GraphicEditorError.new "Value must be an interger"               unless value.to_i.to_s == value.to_s
    raise GraphicEditorError.new "Value must be bigger or equal to 1"      unless value.to_i >= 1
    raise GraphicEditorError.new "Value must be smaller or equal to 250"   unless value.to_i <= 250
    raise GraphicEditorError.new "Value must fit inside canvas dimensions" unless @canvas.empty? || value.to_i <= @height
    return true
  end

  def validate_colour_value!(value)
    raise GraphicEditorError.new "Value must be a single capital letter" unless value =~ /^[A-Z]$/
    return true
  end

  def validate(args_format, args)
    raise GraphicEditorError.new "#{args_format.size} arguments expected, #{args.size} given" unless args_format.size == args.size

    args_format.each_index do |i|
      self.send "validate_#{args_format[i].to_s}_value!".to_sym, args[i]
    end

    return true
  end

end
