# frozen_string_literal: true

class Dealer
  attr_accessor :dealer_score, :dealer_money, :dealer_cards

  def initialize(dealer_money = 100, dealer_score = 0)
    @dealer_score = dealer_score
    @dealer_money = dealer_money
    @dealer_cards = []
  end
end
