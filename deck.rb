# frozen_string_literal: true

class Deck
  attr_accessor :cards, :suits

  def initialize(_cards = [], _suits = [])
    @cards = %w[2 3 4 5 6 7 8 9 10 j q k a]
    spade = '♠'
    heart = '♥'
    club = '♣'
    diamond = '♦'
    @suits = [spade, heart, club, diamond]
  end

  def rand_cards
    cards.sample + suits.sample
  end
end
