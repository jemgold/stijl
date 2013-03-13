require 'ruby-processing'

class Mondrian < Processing::App

  def setup
    @stroke_width = 20
    # @heights = [40, 10, 20]
    # @heights = [40, 80, 120]
    # @heights = [240, 80, 120]
    @heights = [120]
    @colors = []
    @rows = []
    frame_rate 15
    redraw_rows
  end

  def draw
    @rows.each do |row|
      row.draw
      row.boxes.each do |box|
        box.draw
      end
    end
  end

  def random_color
    red = color 211, 64, 46
    black = color 40, 40, 38
    yellow = color 237, 213, 63
    sky = color 228, 247, 247
    blue = color 35, 79, 153
    colors = [red, black, yellow, sky, blue]
    return colors.shuffle.first
  end

  def redraw_rows
    @rows = []
    start = 0
    while start < height
      height = @heights.shuffle[0]
      @rows << Row.new(height, start)
      start += height
    end

  end

  def mouse_pressed
    redraw_rows
  end

end


class Box
  include Processing::Proxy

  def initialize(height, width, startX, startY, parent)
    @height = height
    @width = width
    @startX = startX
    @startY = startY
    @parent = parent
    @color = get_color
    @children = []
  end

  def draw
    fill @color
    no_stroke
    rect @startX, @startY, @width, @height
    mouse_handle
    @children.each {|box| box.draw}
  end

  def mouse_handle
    if mouseY > @startY
      if mouseY < (@startY + @height)
        if mouseX > @startX
          if mouseX < (@startX + @width)
            split
            # @color = get_color
          end
        end
      end
    end
  end

  def split
    if @width > 20
      @children = []
      h = @width/2
      2.times do |i|
        y = @startY + (i * h)
        2.times do |i|
          x = @startX + (i * h)
          @children << Box.new(h, h, x, y, self)
        end
      end
    end
  end

  def get_color
    $app.random_color
  end

end

class Row
  include Processing::Proxy

  def initialize(height, startY)
    @height = height
    @startY = startY
    @boxes = []
    redraw_boxes
  end

  def debug
    rect 0, @startY, $app.width, @height
  end

  def boxes
    @boxes
  end

  def draw
  end

  # def boxes
    # @boxes.each { |box| box.draw  }
    # if mouse_pressed?
    #   if mouseY > @startY
    #     if mouseY < (@startY + @height)
    #       redraw_boxes
    #     end
    #   end
    # end
    # if mouse_clicked?
    #   puts mouseY
    #   puts @startY
    #   puts @height
    #   # if mouseY > @startY
    #   #   if mouseY > (@startY + height)
    #   #     puts @startY + @height
    #   #     # puts mouseY
    #   #   end
    #   # end
    # end
  # end

  def redraw_boxes
    (width/@height).times do |i|
      @boxes << Box.new(@height, @height, i*@height, @startY, self)
    end
  end

end

Mondrian.new :title => "Mondrian", :width => 720, :height => 720
