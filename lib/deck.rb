require_relative "card"

class Deck

  include Suits
  def self.set_deck
    cards_arr = []
    suits = SUITS_HASH.keys
    values = %W(A 2 3 4 5 6 7 8 9 10 J Q K)

    suits.each do |suit|
      values.each do |value|
        cards_arr << Card.new(value, suit)
      end
    end
    Deck.new(cards_arr)
  end

  def initialize(cards = [])
    @cards = cards
  end

  def deck_size
    @cards.length
  end

  def shuffle!
    @cards.shuffle!
    self 
  end

  def give_card!
    @cards.pop
  end
end
