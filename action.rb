class Poker::Action

  attr_accessor :player, :hand, :type

  TYPES = [:post, :fold, :check, :call, :bet, :raise]

  def initialize player, hand, type
    self.player = player
    self.hand = hand
    self.type = type
  end

  def concludes_street?
    type.in?([:call, :fold])
  end

  TYPES.each do |type|
    define_method :"#{ type }?" do
      self.type == type
    end
  end

end


