module Poker
  class HandHistory
    attr_accessor :actions

    STREETS = [:preflop, :flop, :turn, :river]

    def initialize
      @actions = {
        preflop: [],
        flop: [],
        turn: [],
        river: []
      }
    end

    def all_actions
      all_actions = []
      @actions.each do |street, actions|
        all_actions += actions
      end
      all_actions
    end

    def current_street
      if @actions[:river].any?
        :river
      elsif @actions[:turn].any?
        :turn
      elsif @actions[:flop].any?
        :flop
      else
        :preflop
      end 
    end

    def last_action_on_current_street
      @actions[current_street].last
    end

    STREETS.each do |street|
      define_method :"#{ street }?" do
        current_street == street
      end
    end
  end
end
