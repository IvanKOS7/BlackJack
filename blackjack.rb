# frozen_string_literal: true

require_relative 'cards'
require_relative 'player'
require_relative 'dealer'

class BlackJack
  def game
    @dealer.dealer_cards << @car.rand_cards << @car.rand_cards
    @player_name.player_cards << @car.rand_cards << @car.rand_cards
    send :scores, @player_name.player_cards, @player_name, "player_score"
    send :scores, @dealer.dealer_cards, @dealer, "dealer_score"
    bank
    sleep(1)
    player_actions
  end

  def start_game
    @car = Cards.new
    print "Enter your name: "
    @player_name = gets.chomp
    puts "Hello! #{@player_name}"
    @player_name = Player.new
    @dealer = Dealer.new
    game
    puts "♦♦♦♦♦♦♦♦♦♦♦♦♦"
  end

  def player_actions
    loop do
      info
      puts "--------------Menu-------------"
      puts "\nIf you want to SKIP - Enter 1"
      puts "If you want ADD CARD - Enter 2"
      puts "If you want OPEN CARDS - Enter 3"

      player_choice = gets.to_i

      case player_choice
      when 1 then dealers_action
      when 2 then add_card
      when 3 then open_card
      else
        puts "Wrong user input. Please, enter 1, 2, or 3"
      end
      open_card if true
    end
  end

  def dealers_action
    sleep(1)
    if @dealer.dealer_score >= 17
      player_actions
    else
      @dealer.dealer_cards << @car.rand_cards
      send :scores, @dealer.dealer_cards, @dealer, "dealer_score"
    end
  end

  def info
    print "Player cards: #{@player_name.player_cards.inspect}."
    print " Player scores: #{@player_name.player_score.inspect}."
    puts " Player money: #{@player_name.player_money}."
    print "Dealer cards: #{'*' * @dealer.dealer_cards.count}."
    print " Dealer scores: **."
    print " Dealer money: #{@dealer.dealer_money}.\n"
  end

  def open_card
    if @player_name.player_score <= 21 && (@dealer.dealer_score < @player_name.player_score)
      puts "PLAYER WIN!!! "
      @player_name.player_money = @player_name.player_money + @bank
    elsif @player_name.player_score >= 21 || (@dealer.dealer_score > @player_name.player_score)
      @dealer.dealer_money = @dealer.dealer_money + @bank
      puts "CAZINO WIN!!!"
    elsif @player_name.player_score == @dealer.dealer_score
      puts "STANDOFF !!!!"
      @player_name.player_money = @player_name.player_money + 10
      @dealer.dealer_money = @dealer.dealer_money + 10
    end
    end_game
    true
  end

  def end_game
    info
    puts "Dealer_scores: #{@dealer.dealer_score}. Dealers card: #{@dealer.dealer_cards}"
    puts "Do you want to continue playing? Enter: y/n"
    @dealer.dealer_cards = []
    @player_name.player_cards = []
    retry_choise = gets.chomp.to_s
    case retry_choise
    when "y" then game
    when "n" then exit
    end
  end

  def add_card
    sleep(1)
    if @player_name.player_cards.count <= 2 || @player_name.player_score >= 21
      @player_name.player_cards << @car.rand_cards
      send :scores, @player_name.player_cards, @player_name, "player_score"
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

game = BlackJack.new
game.start_game
