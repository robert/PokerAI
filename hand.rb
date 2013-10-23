module Poker
  class Hand
    attr_accessor :game, :deck, :pot_size, :hand_history, :community_cards

    def initialize game
      @game = game
      @deck = Poker::Deck.new
      @community_cards = []
      @pot_size = 0
      @hand_history = Poker::HandHistory.new
    end

    def small_blind
      @game.players[@game.hands.count % @game.players.count]
    end

    def big_blind
      @game.players[(@game.hands.count + 1) % @game.players.count ]
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
      @hand_history.last_action_on_current_street.type == :fold || ( @hand_history.actions[:river].count > 1 && ( @hand_history.last_action_on_current_street.check? || @hand_history.last_action_on_current_street.call? ) )
    end

    # TODO make this method suck less
    def winner
      if finished?
        if fold = @hand_history.all_actions.find(&:fold?)
          winner = (fold.player == small_blind) ? big_blind : small_blind
        else
          winner = if PokerHand.new( small_blind.hole_cards + @community_cards ) > PokerHand.new( big_blind.hole_cards + @community_cards )
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
end
