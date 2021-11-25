# frozen_string_literal: true

class Player
  attr_accessor :player_score, :player_money

  def initialize(player_money = 100, player_score = 0)
    @player_score = player_score
    @player_money = player_money
  #  @player_cards = []
  end
end
