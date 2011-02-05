# The command module implements all the commands that is offered by the
# Graphical Editor. Where applicable it passes control to the Graphic proccessor
# otherwise the command deals with the request locally. 
module Commands

  def i_command(args)
    @graphic_processor = GraphicProcessor.new(args)
  end

  def s_command(args)
    raise GraphicEditorError.new('First initialise an image') unless @graphic_processor
    puts "\n=>"
    @graphic_processor.canvas.each do |line|
      puts line.join
    end
    puts ""
  end

  def c_command(args)
    raise GraphicEditorError.new('First initialise an image') unless @graphic_processor
    @graphic_processor.clear(args)
  end

  def l_command(args)
    raise GraphicEditorError.new('First initialise an image') unless @graphic_processor
    @graphic_processor.paint(args)
  end

  def h_command(args)
    raise GraphicEditorError.new('First initialise an image') unless @graphic_processor
    @graphic_processor.horisontal_line(args)
  end

  def v_command(args)
    raise GraphicEditorError.new('First initialise an image') unless @graphic_processor
    @graphic_processor.vertical_line(args)
  end

  def f_command(args)
    raise GraphicEditorError.new('First initialise an image') unless @graphic_processor
    @graphic_processor.fill(args)
  end

  def x_command(args)
    raise ExitGraphicEditorError
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^[a-z]_command/
      raise GraphicEditorError.new('That command is not implemented')
    else
      super
    end
  end

end