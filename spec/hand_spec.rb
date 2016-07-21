require 'hand'

describe Hand do
  let(:empty_hand) {Hand.new}
  let(:straight_flush) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("J", :C))
    hand.accept!(Card.new("10", :C))
    hand.accept!(Card.new("9", :C))
    hand.accept!(Card.new("8", :C))
    hand.accept!(Card.new("7", :C))
    hand
  end
  let(:four_of_a_kind) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("6", :C))
    hand.accept!(Card.new("6", :D))
    hand.accept!(Card.new("6", :H))
    hand.accept!(Card.new("6", :S))
    hand.accept!(Card.new("7", :C))
    hand
  end

  let(:four_of_a_kind_lower) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("2", :C))
    hand.accept!(Card.new("2", :D))
    hand.accept!(Card.new("2", :H))
    hand.accept!(Card.new("2", :S))
    hand.accept!(Card.new("K", :C))
    hand
  end


  let(:full_house) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("6", :C))
    hand.accept!(Card.new("6", :D))
    hand.accept!(Card.new("7", :H))
    hand.accept!(Card.new("7", :S))
    hand.accept!(Card.new("7", :C))
    hand
  end
  let(:flush) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("6", :C))
    hand.accept!(Card.new("2", :C))
    hand.accept!(Card.new("K", :C))
    hand.accept!(Card.new("10", :C))
    hand.accept!(Card.new("7", :C))
    hand
  end
  let(:straight) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("K", :C))
    hand.accept!(Card.new("Q", :D))
    hand.accept!(Card.new("J", :H))
    hand.accept!(Card.new("10", :S))
    hand.accept!(Card.new("9", :C))
    hand
  end
  let(:three_of_a_kind) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("6", :C))
    hand.accept!(Card.new("A", :D))
    hand.accept!(Card.new("7", :H))
    hand.accept!(Card.new("7", :S))
    hand.accept!(Card.new("7", :C))
    hand
  end
  let(:two_pair) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("6", :C))
    hand.accept!(Card.new("6", :D))
    hand.accept!(Card.new("7", :H))
    hand.accept!(Card.new("7", :S))
    hand.accept!(Card.new("J", :C))
    hand
  end
  let(:one_pair) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("6", :C))
    hand.accept!(Card.new("6", :D))
    hand.accept!(Card.new("Q", :H))
    hand.accept!(Card.new("2", :S))
    hand.accept!(Card.new("7", :C))
    hand
  end
  let(:high_card) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("K", :C))
    hand.accept!(Card.new("6", :D))
    hand.accept!(Card.new("Q", :H))
    hand.accept!(Card.new("2", :S))
    hand.accept!(Card.new("7", :C))
    hand
  end

  let(:high_card_discarded) do |hand|
    hand = Hand.new
    hand.accept!(Card.new("K", :C))
    hand.accept!(Card.new("6", :D))
    hand.accept!(Card.new("Q", :H))
    hand.accept!(Card.new("2", :S))
    # hand.accept!(Card.new("7", :C))
    hand
  end

  describe "Hand#initialize" do
    it "should initialize an empty hand " do
      expect(empty_hand.cards).to be_empty
    end

  end

  describe "Hand#strength" do
    it "should return the hand strength of an empty hand" do
      expect(empty_hand.strength).to eq(10)
    end

    it "should return the hand strength of a straight flush" do
      expect(straight_flush.strength).to eq(1)
    end

    it "should return the hand strength of a four of a kind" do
      expect(four_of_a_kind.strength).to eq(2)
    end

    it "should return the hand strength of a full house" do
      expect(full_house.strength).to eq(3)
    end

    it "should return the hand strength of a flush" do
      expect(flush.strength).to eq(4)
    end

    it "should return the hand strength of a straight" do
      expect(straight.strength).to eq(5)
    end

    it "should return the hand strength of a three of a kind" do
      expect(three_of_a_kind.strength).to eq(6)
    end

    it "should return the hand strength of a two pair" do
      expect(two_pair.strength).to eq(7)
    end

    it "should return the hand strength of a one pair" do
      expect(one_pair.strength).to eq(8)
    end

    it "should return the hand strength of a high card" do
      expect(high_card.strength).to eq(9)
    end

  end

  describe "Hand#discard!" do
    it "should remove a card from the hand at the specified position" do
      expect(high_card.discard!(4).cards.last.value).to eq(high_card_discarded.cards.last.value)
    end
  end

  describe "Hand#accept!" do
    it "should accept a card at the specified location" do
      expect(high_card_discarded.accept!(Card.new("7", :C)).last.value).to eq(high_card.cards.last.value)
    end
  end

  describe "Hand#show" do
    it "should print the hand as cards " do
      expect(one_pair.show).to eq("(6, \u2663) (6, \u2662) (Q, \u2661) (2, \u2660) (7, \u2663) ")
    end
  end

  describe "Hand#tiebreaker" do
    it "should take the higher of two similarly ranked hands" do
      expect(four_of_a_kind.tiebreaker(four_of_a_kind_lower)).to eq(1)
    end
  end

  describe "Hand#n_of_a_kind?" do
    it "should return a hash of frequencies " do
      expect(full_house.n_of_a_kind?).to be_a(Hash)
    end
  end


end
