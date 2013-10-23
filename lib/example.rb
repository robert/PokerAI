require './action'
require './card'
require './deck'
require './game'
require './game_dealer'
require './hand'
require './hand_dealer'
require './hand_history'
require './player'

player1 = Poker::Player.new("Barry")
player2 = Poker::Player.new("Gonad")

game = Poker::Game.new

game_dealer = Poker::GameDealer.new(game)
game_dealer.add_player_to_game(player1)
game_dealer.add_player_to_game(player2)

game_dealer.deal_game
