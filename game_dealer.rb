module Poker
  class GameDealer
    attr_reader :game

    def initialize game
      @game = game
    end

    def add_player_to_game player
      @game.players << player
      player.stack_size = Poker::Game::START_STACK
    end

    def deal_game
      until @game.players.any?(&:bust?) || @game.hands.count > 100
        hand = Poker::Hand.new(sel )
        @game.hands << hand
        Poker::HandDealer.new(hand).deal_hand
      end
      if @game.players[0].bust?
        puts "#{ @game.players[1].name } WINS!!!"
      elsif @game.players[1].bust?
        puts "#{ @game.players[0].name } WINS!!!"
      else
        puts "NO ONE WINS????"
      end
    end
  end
end
