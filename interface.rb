require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'blackjack'

jack = BlackJack.new
puts "Enter your name: "
jack.start_game
puts "Hello!"
puts "♦♦♦♦♦♦♦♦♦♦♦♦♦"
jack.game
loop do
  puts "--------------Menu-------------"
  puts "\nIf you want to SKIP - Enter 1"
  puts "If you want ADD CARD - Enter 2"
  puts "If you want OPEN CARDS - Enter 3"
  puts "Enter 0 to exit"
  jack.player_actions
end
