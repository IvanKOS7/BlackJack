# frozen_string_literal: true

require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'hand'
require_relative 'interface'

class BlackJack
  def start_game
    @deck = Deck.new
    @deck.deck_card
    @dealer = Dealer.new
    @interface = Interface.new
    @interface.start_interface
    @player_name = Player.new
  end

  def game
    @player_name.player_hand.hand << @deck.rand_cards
    @player_name.count_score_player
    @player_name.player_hand.hand << @deck.rand_cards
    @player_name.count_score_player
    @dealer.dealer_hand.hand << @deck.rand_cards
    @dealer.count_score_dealer
    @dealer.dealer_hand.hand << @deck.rand_cards
    @dealer.count_score_dealer
    bank
    @interface.info(@player_name, @dealer)
    sleep(1)
    @interface.menu { user_action }
  end

  def user_action
    @interface.info(@player_name, @dealer)
    @player_choice = gets.chomp.to_i

    case @player_choice
    when 1 then dealers_action
    when 2 then add_card
    when 3 then open_card
    when 0 then exit
    else
      raise "Wrong user input. Please, enter 1, 2, or 3"
    end
  end

  def dealers_action
    sleep(1)
    if @dealer.dealer_score <= 17 && @dealer.dealer_hand.hand.count < 3
      @dealer.dealer_hand.hand << @deck.rand_cards
      @dealer.dealer_hand.scores(@dealer.dealer_hand.hand, @dealer, "dealer_score")
    else
      open_card
    end
  end

  def comprasion_result
    @dealer_result = @dealer.dealer_score
    @player_result = @player_name.player_score
    @dealer_result <=> @player_result
  end

  def player_win
    @interface.open_card(@player_name.to_s.capitalize)
    @player_name.player_money = @player_name.player_money + @bank
  end

  def dealer_win
    @interface.open_card("CAZINO")
    @dealer.dealer_money = @dealer.dealer_money + @bank
  end

  def standoff
    puts "STANDOFF !!!!"
    @player_name.player_money = @player_name.player_money + 10
    @dealer.dealer_money = @dealer.dealer_money + 10
  end

  def open_card
    comprasion_result
    if (comprasion_result == -1) && (@player_result <= 21)
      player_win
    elsif (comprasion_result == 1) && (@dealer_result <= 21)
      dealer_win
    elsif (comprasion_result == - 1) && (@player_result > 21)
      dealer_win
    elsif (comprasion_result) == 1 && (@dealer_result > 21)
      player_win
    elsif comprasion_result == 0
      standoff
    end
     @interface.secret_info(@player_name, @dealer)
    @dealer.dealer_hand.hand = []
    @player_name.player_hand.hand = []
    @interface.end_game { end_game }
  end

  def end_game
    @retry_choice = gets.chomp.to_s
    case @retry_choice
    when "y" then game
    when "n" then exit
    else
      raise "Enter y/n"
    end
  end

  def add_card
    sleep(1)
    if (@player_name.player_hand.hand.count < 3) && (@player_name.player_score <= 21)
      @player_name.player_hand.hand << @deck.rand_cards
      @player_name.player_hand.scores(@player_name.player_hand.hand, @player_name, "player_score")
    else
      dealers_action
    end
  end

  def bank
    bet = 10
    @bank = 0
    @player_name.player_money = @player_name.player_money - bet
    @bank += 10
    @dealer.dealer_money = @dealer.dealer_money - bet
    @bank += 10
    puts "Bank: #{@bank}"
  end
  # BlackJack
end
