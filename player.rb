# frozen_string_literal: true

require_relative 'hand'
require_relative 'deck'

class Player
  attr_accessor :player_score, :player_money, :player_hand

  def initialize(player_money = 100, player_score = 0, player_hand = Hand.new)
    @player_hand = player_hand
    @player_score = player_score
    @player_money = player_money
  end

  def create_hand
    # @deck.rand_cards
    # @player_hand.hand << @deck.rand_cards << @deck.rand_cards
  end

  def count_score_player
    player_hand.scores(player_hand.hand, self, "player_score")
  end
end
