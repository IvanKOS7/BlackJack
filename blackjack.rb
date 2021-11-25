# frozen_string_literal: true

require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'hand'

class BlackJack

  def start_game
    @deck = Deck.new
    @deck.deck_card
    @player_hand = Hand.new
    @dealer_hand = Hand.new
    @dealer = Dealer.new
    @player_name = gets.chomp
    @player_name = Player.new
  end

  def game
    @dealer_hand.hand << @deck.rand_cards << @deck.rand_cards
    @player_hand.hand << @deck.rand_cards << @deck.rand_cards
    scores(@player_hand.hand, @player_name, "player_score")
    scores(@dealer_hand.hand, @dealer, "dealer_score")
    bank
    sleep(1)
  end

  def player_actions
      info
      player_choice = gets.to_i
      case player_choice
        when 1 then dealers_action
        when 2 then add_card
        when 3 then open_card
        when 0 then exit
      else
        raise "Wrong user input. Please, enter 1, 2, or 3"
      end
    rescue => e
      puts e.message
      retry
  end

  def dealers_action
    sleep(1)
    if @dealer.dealer_score >= 17
      player_actions
    else
      @dealer_hand.hand << @deck.rand_cards
      scores(@dealer_hand.hand, @dealer, "dealer_score")
    end
  end

  def info
    print "Player cards: #{@player_hand.hand.inspect}."
    print " Player scores: #{@player_name.player_score.inspect}."
    puts " Player money: #{@player_name.player_money}."
    print "Dealer cards: #{'*' * @dealer_hand.hand.count}."
    print " Dealer scores: **."
    print " Dealer money: #{@dealer.dealer_money}.\n"
  end

  def open_card
    if @dealer.dealer_score >= 21 || (@dealer.dealer_score < @player_name.player_score && (@player_name.player_score <= 21))
      puts "PLAYER WIN!!! "
      @player_name.player_money = @player_name.player_money + @bank
    elsif @player_name.player_score >= 21 || (@dealer.dealer_score > @player_name.player_score && (@dealer.dealer_score <= 21))
      @dealer.dealer_money = @dealer.dealer_money + @bank
      puts "CAZINO WIN!!!"
    elsif @player_name.player_score == @dealer.dealer_score
      puts "STANDOFF !!!!"
      @player_name.player_money = @player_name.player_money + 10
      @dealer.dealer_money = @dealer.dealer_money + 10
    end
    end_game
  end

  def end_game
    info
    puts "Dealer_scores: #{@dealer.dealer_score}. Dealers card: #{@dealer_hand.hand}"
    puts "Do you want to continue playing? Enter: y/n"
    @dealer_hand.hand = []
    @player_hand.hand = []
    begin
      retry_choise = gets.chomp.to_s
      case retry_choise
        when "y" then game
        when "n" then exit
      else
        raise "Enter y/n"
     end
    rescue => e
      puts e.message
      retry
    end
  end

  def add_card
    sleep(1)
    if @player_hand.hand.count < 3 || @player_name.player_score <= 21
      @player_hand.hand << @deck.rand_cards
      scores(@player_hand.hand, @player_name, "player_score")
    else
      open_card
    end
  end

  def scores(cards_array, instance_var, score)
    score_numbers ||= 0
    cards_array.each do |value|
      value_int = value.gsub(/[\u2660\u2665\u2663\u2666]/, '')
      value_card = value_int.to_i
      if value_card != 0
        score_numbers += value_card
      elsif  value_int !~ /a/
        score_numbers += 10
      else
        if  instance_var.send("#{score}") <= 21
          score_numbers += 11
        else
          score_numbers += 1
        end
      end
    end
    instance_var.send("#{score}=", score_numbers)
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
