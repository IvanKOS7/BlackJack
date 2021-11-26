require_relative 'card'

class Deck
  attr_accessor :deck

  def initialize(deck = [])
    @deck = deck
    @card = Card.new
  end

  def do_deck
    card_value_arr = %w[2 3 4 5 6 7 8 9 10 j q k a]
    suit_arr = ['♠', '♥', '♣', '♦']
    suit_arr.each do |suit|
      deck << card_value_arr.map { |card_value| Card.new(suit = suit, card_value = card_value) }
      deck.flatten!.shuffle!          # number = Card.new(suit=suit_arr, card_value= card_arr)        # deck << number
    end
  end

  def rand_cards
    rand_card = deck.sample(random: Random.new(1))
    deck.delete(rand_card)
  end
end
