require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'blackjack'
require_relative 'hand'

class Interface
  def start_interface
    puts "Enter your name: "
    @player_name = gets.chomp
    puts "Hello! #{@player_name}"
    puts "♦♦♦♦♦♦♦♦♦♦♦♦♦"
  end

  def open_card(who)
    puts "A #{who} WIN!!!"
  end

  def menu
    loop do
      puts "--------------Menu-------------"
      puts "\nIf you want TO SKIP - Enter 1"
      puts "If you want ADD CARD - Enter 2"
      puts "If you want OPEN CARDS - Enter 3"
      puts "Enter 0 to exit"
      yield

    rescue StandardError => e
      puts e.inspect
      retry
    end
  end

  def end_game
    puts "Do you want to continue playing? Enter: y/n"

    begin
      yield
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def info(player_object, dealer_object)
    print "Player cards: #{player_object.player_hand.hand.inspect}."
    print " Player scores: #{player_object.player_score.inspect}."
    puts " Player money: #{player_object.player_money}."
    print "Dealer cards: #{'*' * dealer_object.dealer_hand.hand.count}."
    print " Dealer scores: **."
    print " Dealer money: #{dealer_object.dealer_money}.\n"
  end

  def secret_info(player_object, dealer_object)
    print "Player cards: #{player_object.player_hand.hand.inspect}."
    print " Player scores: #{player_object.player_score.inspect}."
    puts " Player money: #{player_object.player_money}."
    print "Dealer cards: #{dealer_object.dealer_hand.hand}."
    print " Dealer scores: #{dealer_object.dealer_score}"
    print " Dealer money: #{dealer_object.dealer_money}.\n"
  end
end
