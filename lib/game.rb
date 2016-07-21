require_relative 'player'
require_relative 'deck'
require 'byebug'

class Game

  def initialize(players = [Player.new], deck= Deck.set_deck, pot=0)
    @players = players
    @deck = deck
    @pot = pot
    @current_player = players.first
    @round_over = false
    @dealer_hand = Hand.new
    # @end_of_turn = true
  end

  def run
    @deck.shuffle!
    deal_cards
    @round_over = false
    @current_player.pot -= 100
    @pot += 100
    until @round_over
      play_turn
    end

    puts "Your hand is"
    puts @current_player.hand.show
    puts "The dealer hand is"
    puts @dealer_hand.show

    if @current_player.hand.strength < @dealer_hand.strength
      puts "You won!"
      @current_player.pot += @pot * 2
    elsif @current_player.hand.strength == @dealer_hand.strength
      if @current_player.hand.tiebreaker(@dealer_hand) == 1
        puts "You won!"
        @current_player.pot += @pot * 2
      end
    end

  end

  def deal_cards
    5.times do
      # byebug
      @current_player.hand.accept!(@deck.give_card!)
      @dealer_hand.accept!(@deck.give_card!)
    end
  end

  def play_turn
    puts @current_player.hand.show
    response = @current_player.get_input
    case response
    when "R"
      @pot += @current_player.raise_bet
      @round_over = true
      # switch_current_player
      # @end_of_turn = !@end_of_turn
    when "D"
      @current.discard
      @current_player.hand.accept!(@deck.give_card!)
    when "S"
      puts "The pot is #{@pot}"
      # switch_current_player
    when "C"
      @round_over = true
    end
  end

  private

  def switch_current_player
    @current_player = (@current_player == @players.first? ? @players[1] : @players.first)
  end



end #end class

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.run
end
