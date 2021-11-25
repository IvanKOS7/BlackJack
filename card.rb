class Card
  attr_accessor :suit, :card_value

  def initialize(suit = [], card_value = [])
    @card_value = card_value
    @card_value = %w[2 3 4 5 6 7 8 9 10 j q k a]
    @suit = suit
    @suit = ['♠', '♥', '♣', '♦']
  end
end
