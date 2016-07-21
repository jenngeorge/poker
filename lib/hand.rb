require_relative "deck"

class Hand
  include Suits

  attr_reader :cards

  def initialize
    @cards = []
  end

  def strength
    return 10 if @cards.length < 5
    return 1 if straight_flush?
    return 2 if four_of_a_kind?
    return 3 if full_house?
    return 4 if flush?
    return 5 if straight?
    return 6 if three_of_a_kind?
    return 7 if two_pair?
    return 8 if pair?

    9
  end

  def accept!(card)
    @cards << card
  end

  def discard!(position)
    @cards.delete_at(position)
    self
  end

  def show
    str = ""
    @cards.each do |card|
      str += "(#{card.to_s}) "
    end
    str
  end

  def n_of_a_kind?
    cards_freq = Hash.new {|h, k| h[k] = 0}
    @cards.each do |card|
      cards_freq[card.value] += 1
    end
    cards_freq
  end

  def tiebreaker(hand)
    return nil unless hand.strength == self.strength

    case self.strength
    when 1, 5
      self_values = @cards.map { |card| VALUES_HASH[card.value] }
      self_max = self_values.reject { |el| el == 14 }.max
      other_values = hand.cards.map { |card| VALUES_HASH[card.value] }
      other_max = other_values.reject { |el| el == 14 }.max
    when 4, 9
      self_max = @cards.map { |card| VALUES_HASH[card.value] }.max
      other_max = hand.cards.map { |card| VALUES_HASH[card.value] }.max
    when 2, 3, 6
      self_max = nil
      self.n_of_a_kind?.each { |key, val| self_max = VALUES_HASH[key] if val > 2 }
      other_max = nil
      hand.n_of_a_kind?.each { |key, val| other_max = VALUES_HASH[key] if val > 2 }
    when 7
      freqs = n_of_a_kind?.select { |key, val| val == 2 }
      self_max = (VALUES_HASH[freqs.keys[0]] > VALUES_HASH[freqs.keys[1]] ? VALUES_HASH[freqs.keys[0]] : VALUES_HASH[freqs.keys[1]])
      other_freqs = hand.n_of_a_kind?.select { |key, val| val == 2 }
      other_max = (VALUES_HASH[other_freqs.keys[0]] > VALUES_HASH[other_freqs.keys[1]] ? VALUES_HASH[other_freqs.keys[0]] : VALUES_HASH[other_freqs.keys[1]])
    when 8
      self_max = nil
      self.n_of_a_kind?.each { |key, val| self_max = VALUES_HASH[key] if val == 2 }
      other_max = nil
      hand.n_of_a_kind?.each { |key, val| other_max = VALUES_HASH[key] if val == 2 }
    end
    self_max <=> other_max
  end

  private
  def straight_flush?
    flush? && straight?
  end

  def flush?
    return false unless cards.all? { |card| card.suit == cards.first.suit }
    true
  end

  def straight?
    sorted_cards = sort
    return false if sorted_cards.last.value == "A" &&
      sorted_cards[-2].value != "K" &&
      sorted_cards[-2].value != "5"

    (0...cards.length - 1).each do |idx|
       return false unless VALUES_HASH[sorted_cards[idx+1].value] - VALUES_HASH[sorted_cards[idx].value] ==1
    end
    true
  end



  def four_of_a_kind?
    n_of_a_kind?.values.include?(4)
  end

  def full_house?
    return false unless n_of_a_kind?.values.include?(3)
    n_of_a_kind?.values.include?(2)
  end

  def three_of_a_kind?
    n_of_a_kind?.values.include?(3)
  end

  def two_pair?
    freqs = n_of_a_kind?.values
    freqs.select { |el| el == 2}.length == 2
  end

  def pair?
    n_of_a_kind?.values.include?(2)
  end

  def compare(card1, card2)
    VALUES_HASH[card1.value] <=> VALUES_HASH[card2.value]
  end

  def sort
    cards_dup = @cards.dup
    sorted = false
    until sorted
      sorted = true
      (0...cards_dup.length).each do |idx|
        jdx = idx
        until jdx == cards_dup.length
          if compare(cards_dup[idx], cards_dup[jdx]) == 1
            cards_dup[idx], cards_dup[jdx] = cards_dup[jdx], cards_dup[idx]
            sorted = false
          end
          jdx+=1
        end
      end
    end
    cards_dup
  end
end
