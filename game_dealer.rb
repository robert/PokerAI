class Poker::GameDealer

  attr_reader :game
  delegate :players, :hands, to: :game

  def initialize game
    @game = game
  end

  def add_player_to_game player
    players << player
    player.stack_size = Poker::Game::START_STACK
  end

  def deal_game
    until players.any?(&:bust?) || hands.count > 100
      hand = Poker::Hand.new( self )
      hands << hand
      Poker::HandDealer.new(hand).deal_hand
    end
    if players[0].bust?
      puts "#{ players[1].name } WINS!!!"
    elsif players[1].bust?
      puts "#{ players[0].name } WINS!!!"
    else
      puts "NO ONE WINS????"
    end
  end

end