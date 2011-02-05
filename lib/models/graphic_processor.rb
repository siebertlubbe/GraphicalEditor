# The Graphic Processor implements the canvas that stores the image as well as
# all the methods to manipulate the image.
class GraphicProcessor
  require File.dirname(__FILE__) + '/validations/graphic_processor_validations.rb'
  include GraphicProcessorValidations

  attr_reader :canvas, :width, :height

  # initialize an image of specified size
  def initialize(args)
    @canvas         = []
    args_format = [:x_coordinate, :y_coordinate]
    validate(args_format, args)

    @width          = args[0].to_i
    @height         = args[1].to_i
    colour  = 'O'

    for y in 1..height do
      row = []
      for x in 1..width do
        row << colour
      end
      @canvas << row
    end
    @canvas
  end

  # clear the image
  def clear(args)
    args_format = []
    validate(args_format, args)

    @canvas.each do |line|
      line.fill('O')
    end
  end

  # paint a specified pixel on the image
  def paint(args)
    args_format = [:x_coordinate, :y_coordinate, :colour]
    validate(args_format, args)

    x_coordinate  = args[0].to_i - 1
    y_coordinate  = args[1].to_i - 1
    colour        = args[2]

    @canvas[y_coordinate][x_coordinate] = colour
    @canvas
  end

  # draw a horisontal line
  def horisontal_line(args)
    args_format = [:x_coordinate, :x_coordinate, :y_coordinate, :colour]
    validate(args_format, args)

    x_coordinates   = args[0..1].sort.collect { |x| x.to_i - 1 }
    y_coordinate    = args[2].to_i - 1
    colour          = args[3]

    @canvas[y_coordinate].fill(colour, x_coordinates[0]..x_coordinates[1])
    @canvas
  end

  # draw a vertical line
  def vertical_line(args)
    args_format = [:x_coordinate, :y_coordinate, :y_coordinate, :colour]
    validate(args_format, args)

    x_coordinate    = args[0].to_i - 1
    y_coordinates   = args[1..2].sort.collect { |y| y.to_i - 1 }
    colour          = args[3]

    for y_coordinate in y_coordinates[0]..y_coordinates[1]
      @canvas[y_coordinate][x_coordinate] = colour
    end

    @canvas
  end

  # fill an pixel and all its bordering pixels with the same colour
  def fill(args)
    args_format = [:x_coordinate, :y_coordinate, :colour]
    validate(args_format, args)

    x_coordinate  = args[0].to_i - 1
    y_coordinate  = args[1].to_i - 1
    colour        = args[2]

    iterate_region(x_coordinate, y_coordinate)

    @canvas.each_index do |row|
      @canvas[row].each_index do |column|
        @canvas[row][column] = colour if @canvas[row][column] == '$'
      end
    end
    
  end

  # itereate over all bordering pixels of a pixel with the same colour and
  # mark them to be painted over later
  def iterate_region(x, y)
    old_colour = @canvas[y][x]
    @canvas[y][x] = '$'
    iterate_region(x - 1, y) if (x - 1 >= 0) && @canvas[y][x - 1] == old_colour
    iterate_region(x + 1, y) if (x + 1 <= @width - 1) && @canvas[y][x + 1] == old_colour
    iterate_region(x, y - 1) if (y - 1 >= 0) && @canvas[y - 1][x] == old_colour
    iterate_region(x, y + 1) if (y + 1 <= @height - 1) && @canvas[y + 1][x] == old_colour
  end

end

