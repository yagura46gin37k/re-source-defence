class Deck
  attr_reader :hand_sprites

  def initialize()
    @deck_recipe = [
      [CardInfo::FARM, 3],
      [CardInfo::MARKET, 3],
      [CardInfo::TEST, 1]
    ]
    @hands = []
    @hand_sprites = []
    @discards = []
    @deck = []
    build
  end

  def build
    @deck_recipe.each do |card|
      card[1].times do
        @deck << card[0]
      end
    end
    @deck = @deck.shuffle
  end

  def show
    p "----- deck recipe -----"
    @deck_recipe.each_with_index do |info, i|
      p "#{info[0][0]} * #{info[1]}"
    end
    p "-------- deck --------"
    @deck.each_with_index do |info, i|
      p "#{i}: #{info[0]}"
    end
    p "----------------------"
  end

  def drawCard
    if @deck.length == 0
      @deck_recipe = []
      card_types = @discards.uniq
      card_types.each do |card|
        @deck_recipe << [card, @discards.count(card)]
      end
      build
      @discards = []
      show
    end

    @hands << @deck.pop
    @hands.last
  end

  def disCard
    @discards.concat(@hands)
    @hands = []
    @hand_sprites = []
  end

  def draw
    if @hand_sprites.length == 0
      @hands.each_with_index do |card, i|
        @hand_sprites << Card.new(100 + i * 150, 300, card)
      end
    end
    Sprite.draw(@hand_sprites)
  end
end
