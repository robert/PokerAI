require_relative 'lib/action.rb'
require_relative 'lib/card'
require_relative 'lib/deck'
require_relative 'lib/game'
require_relative 'lib/game_dealer'
require_relative 'lib/hand'
require_relative 'lib/hand_dealer'
require_relative 'lib/hand_history'
require_relative 'lib/player'

require 'ruby-poker'

player1 = Poker::Player.new("Barry")
player2 = Poker::Player.new("Gonad")

game = Poker::Game.new

game_dealer = Poker::GameDealer.new(game)
game_dealer.add_player_to_game(player1)
game_dealer.add_player_to_game(player2)

game_dealer.deal_game
