require_relative 'card'

class Deck
  attr_accessor :deck

  def initialize(deck = [])
    @deck = deck
    @card = Card.new
  end

  def deck_card
    @card.suit.each  do |suit|
      deck << @card.card_value.map {|card_value| card_value + "#{suit}"}
      deck.flatten!.shuffle!
    end
  end

  def rand_cards
    rand_card = self.deck.sample(random: Random.new(1))
    self.deck.delete(rand_card)
  end
end
