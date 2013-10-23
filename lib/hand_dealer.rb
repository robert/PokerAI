module Poker
  class HandDealer
    attr_reader :hand

    def initialize hand
      @hand = hand
    end

    def deal_hand
      post_small_blind @hand.small_blind
      post_big_blind @hand.big_blind

      @hand.small_blind.hole_cards = @hand.deck.deal(2)
      @hand.big_blind.hole_cards = @hand.deck.deal(2)

      betting_for_street :preflop
      award_pot and return if @hand.finished?

      deal_community_cards 3
      betting_for_street :flop
      award_pot and return if @hand.finished?

      deal_community_cards 1
      betting_for_street :turn
      award_pot and return if @hand.finished?

      deal_community_cards 1
      betting_for_street :river

      award_pot
    end

    private

    def resolve_action action
      send(action.type, action.player)
      
      puts "#{action.player.name}\t#{action.type.capitalize}\t#{@hand.pot_size}\t#{@hand.game.players[0].stack_size}\t#{@hand.game.players[1].stack_size}"
    end

    def deal_community_cards n_cards
      @hand.community_cards += @hand.deck.deal(n_cards)
      puts @hand.community_cards.join(",")
    end

    def betting_for_street street
      next_actor = (street == :preflop) ? @hand.small_blind : @hand.big_blind

      begin
        last_action = Poker::Action.new next_actor, @hand, next_actor.decide( @hand.current_state )
        @hand.hand_history.actions[street] << last_action

        resolve_action last_action

        next_actor = (next_actor == @hand.small_blind) ? @hand.big_blind : @hand.small_blind
      end while not last_action.concludes_street?
    end

    def award_pot
      @hand.winner.stack_size += @hand.pot_size

      puts ["",
      "#{ @hand.small_blind.name } HAS #{ @hand.small_blind.hole_cards }",
      "#{ @hand.big_blind.name } HAS #{ @hand.big_blind.hole_cards }",
      @hand.community_cards.join(","),
      "",
      "POT AWARDED TO #{ @hand.winner.name }",
      ""]
    end

    def post_small_blind player
      put_chips_in_pot player, Poker::Game::SMALL_BLIND_AMOUNT
    end

    def post_big_blind player
      put_chips_in_pot player, Poker::Game::BIG_BLIND_AMOUNT
    end

    def bet player
      put_chips_in_pot player, Poker::Game::BIG_BLIND_AMOUNT
    end

    def raise player
      put_chips_in_pot(player, 2 * Poker::Game::BIG_BLIND_AMOUNT)
    end

    def call player
      put_chips_in_pot(player, Poker::Game::BIG_BLIND_AMOUNT)
    end

    def check player

    end

    def put_chips_in_pot player, n_chips
      player.stack_size -= n_chips
      @hand.pot_size += n_chips
    end
  end
end
