require 'card'

describe Card do
  let(:card) {Card.new}

  describe "Card#initialize" do
    it "sets a value to a card" do
      expect(card.value).to eq("A")
    end
    it "gives a suit to the card" do
      expect(card.suit).to eq(:S)
    end
  end

  describe "Card#to_s" do
    it "returns card as a string " do
      expect(card.to_s).to eq("A spades")
    end
  end 
end #Card do end
