module Poker
  class Action
    attr_accessor :player, :hand, :type

    TYPES = [:post, :fold, :check, :call, :bet, :raise]

    def initialize player, hand, type
      @player = player
      @hand = hand
      @type = type
    end

    def concludes_street?
      @type.in?([:call, :fold])
    end

    TYPES.each do |type|
      define_method :"#{ type }?" do
        @type == type
      end
    end
  end
end

