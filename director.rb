class Director
  def initialize
    @background = Image.new(Window.width, Window.height, C_WHITE)
    @menu = Menu.new
    @cells = []
  end

  def input
  end

  def play
    10.times do |y|
      10.times do |x|
        @cells << Cell.new(x * 21, y * 21)
      end
    end
  end

  def draw
    Window.draw(0, 0, @background)
    Sprite.draw(@cells)
    @menu.draw
  end
end
