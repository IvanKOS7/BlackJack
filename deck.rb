require_relative 'card'

class Deck
  attr_accessor :deck

  def initialize(deck = [])
    @deck = deck
    @card = Card.new
  end

  def deck_card
    @card.suit.each do |suit|
      deck << @card.card_value.map { |card_value| card_value + suit.to_s }
      deck.flatten!.shuffle!
    end
  end

  def rand_cards
    rand_card = deck.sample(random: Random.new(1))
    deck.delete(rand_card)
  end
end
