require_relative "suits"

class Card
  include Suits

  attr_reader :value, :suit

  def initialize(value="A", suit=:S)
    @value = value
    @suit = suit
  end

  def to_s
    [@value, SUITS_HASH[@suit]].join(", ")
  end
end
