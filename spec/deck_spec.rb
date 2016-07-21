require "deck"

describe Deck do
  let(:deck) {Deck.set_deck}
  let(:another_deck) {Deck.set_deck}
  describe "Deck#set_deck" do
    it "should have 52 cards" do
      expect(deck.deck_size).to eq(52)
    end
    # it "should have 52 unique cards" do
    #   expect(deck.cards.uniq.length).to eq(52)
    # end
  end

  describe "Deck#shuffle" do
    it "should rearrange the order of cards " do
      deck.shuffle!
      expect(deck).not_to eq(another_deck)
    end
  end

  describe "Deck#give_card" do
    it "should return a card and decrease the size of the deck by 1" do
      expect(deck.give_card!).to be_a(Card)
      expect(deck.deck_size).to eq(51)
    end
  end

end
