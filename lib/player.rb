require_relative "hand"

class Player
  attr_reader :name, :hand
  attr_accessor :pot

  def initialize(name = "Polly", pot = 1000, hand = Hand.new)
    @name = name
    @pot = pot
    @hand = hand
  end

  def raise_bet
    puts "How much do you want to raise?"
    input = gets.chomp.to_i
    @pot -= input
    input
  end

  def discard
    puts "Which card (position starting from 0) would you like to discard?"
    input = gets.chomp.to_i
    @hand.discard!(input)
  end

  def get_input
    puts "Would you like to R)aise F)old D)iscard S)ee C)heck ?"
    input = gets.chomp
  end

end
