# frozen_string_literal: true

require_relative 'hand'

class Dealer
  attr_accessor :dealer_score, :dealer_money, :dealer_hand

  def initialize(dealer_money = 100, dealer_score = 0, dealer_hand = Hand.new)
    @dealer_hand = dealer_hand
    @dealer_score = dealer_score
    @dealer_money = dealer_money
  end

  def count_score_dealer
    dealer_hand.scores(dealer_hand.hand, self, "dealer_score")
  end
end
