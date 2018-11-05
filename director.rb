class Director
  PHASE = [:draw, :standby, :main, :battle, :end]

  def initialize
    @title = Image.new(Window.width, Window.height, C_BLUE)
    @background = Image.new(Window.width, Window.height, C_WHITE)
    @menus = {:draw => Menu.new(0, 0, C_BLUE, "Draw"),
              :standby => Menu.new(0, 50, C_GREEN, "Standby"),
              :main => Menu.new(0, 100, C_RED, "Main"),
              :battle => Menu.new(0, 150, C_BLACK, "Battle"),
              :end => Menu.new(0, 200, C_BLACK, "End")}
    @mapIds = [[0, 1, 2, 0],
              [2, 0, 0, 1, 2],
              [1, 1, 2, 0]]
    @map = MapData.new(100, 200, @mapIds)
    @scene = :title
    @pnum = 0
    @phase = PHASE[@pnum]

=begin
    @cards = {:farm => Card.new(100, 300, "farm", "+1 food", :color1 => C_GREEN, :color2 => C_WHITE),
              :market => Card.new(250, 300, "market", "+1 gold", :color1 => C_YELLOW, :color2 => C_WHITE),
              :test => Card.new(400, 300, "01234567", "01234567890this is newline test", :color1 => C_BLUE, :color2 => [255, 200, 200, 200])}
=end
    @cards = [Card.new(100, 300, CardInfo::MARKET, :color1 => C_YELLOW, :color2 => C_WHITE),
              Card.new(250, 300, CardInfo::TEST, :color1 => C_BLUE, :color2 => [255, 200, 200, 200])]
    @mouse = Mouse.new
    @kingdom = Kingdom.new
  end

  def input
    @mouse.x = Input.mouse_pos_x
    @mouse.y = Input.mouse_pos_y
    @mouse.push = Input.mouse_push?(M_LBUTTON)
  end

  def play
    case @scene
    when :title
      @scene = :game if Input.key_down?(K_SPACE)
    when :game
      case @phase
      when :draw
      when :standby
      when :main
      when :battle
      when :end
      end
      if @mouse === @menus[@phase] and @mouse.push
        @pnum += 1
        @pnum %= PHASE.length
        @phase = PHASE[@pnum]
      end
    end
  end

  def draw
    case @scene
    when :start
      Window.draw(0, 0, @title)
    when :game
      Window.draw(0, 0, @background)
      Sprite.draw(@cells)
      Sprite.draw(@menus[@phase])
      @map.draw
      Sprite.draw(@cards)
    end
  end
end
