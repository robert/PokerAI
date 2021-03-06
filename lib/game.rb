module Poker
  class Game
    START_STACK = 1500

    SMALL_BLIND_AMOUNT = 25
    BIG_BLIND_AMOUNT = 50

    attr_accessor :players
    attr_accessor :hands

    def initialize
      @players = []
      @hands = []
    end

    def current_hand
      @hands.last
    end
  end
end
