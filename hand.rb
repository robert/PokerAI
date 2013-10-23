class Poker::Hand

  attr_accessor :game, :deck, :pot_size, :small_blind, :big_blind, :hand_history, :community_cards
  delegate :players, to: :game

  def initialize game
    self.game = game
    self.deck = Poker::Deck.new
    self.community_cards = []
    self.pot_size = 0
    self.hand_history = Poker::HandHistory.new
  end

  def small_blind
    players[game.hands.count % players.count]
  end

  def big_blind
    players[(game.hands.count + 1) % players.count ]
  end

  def current_state
    State.new(
      small_blind.stack_size,
			big_blind.stack_size,
			pot_size,
			hand_history,
      community_cards
    )
  end

  # TODO make this method suck less
  def finished?
    hand_history.last_action_on_current_street.type == :fold || ( hand_history.actions[:river].count > 1 && ( hand_history.last_action_on_current_street.check? || hand_history.last_action_on_current_street.call? ) )
  end

  # TODO make this method suck less
  def winner
    if finished?
      if fold = hand_history.all_actions.find(&:fold?)
        winner = (fold.player == small_blind) ? big_blind : small_blind
      else
        winner = if PokerHand.new( small_blind.hole_cards + community_cards ) > PokerHand.new( big_blind.hole_cards + community_cards )
          small_blind
        else
          big_blind
        end
      end
    else
      nil
    end
  end

  class State < Struct.new(:player1_stack_size, :player2_stack_size, :pot_size, :hand_history, :community_cards)
  end

end
