class Poker::Player

  attr_accessor :stack_size, :game, :hole_cards, :name

  def initialize name = "Gonad"
    self.name = name
  end

  def decide hand_state
    if hand_state.hand_history.last_action_on_current_street
      case hand_state.hand_history.last_action_on_current_street.type
      when :raise, :bet
        if stack_size > 1000
          :raise
        else
          :call
        end
      when :check
        if stack_size > 1000
          :bet
        else
          :call
        end
      else
        if stack_size > Poker::Game::BIG_BLIND_AMOUNT
          :bet
        else
          :check
        end
      end
    else
      if stack_size > Poker::Game::BIG_BLIND_AMOUNT
        if hand_state.hand_history.preflop?
          :raise
        else
          :bet
        end
      else
        :check
      end
    end
  end

  def bust?
    stack_size < Poker::Game::BIG_BLIND_AMOUNT
  end

end
