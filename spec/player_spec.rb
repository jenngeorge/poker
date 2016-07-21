require 'player'

describe Player do
  let(:player) {Player.new}
  describe "Player#initialize" do
    it "Player#name sets a name" do
      expect(player.name).to eq("Polly")
    end
    it "Player#pot sets the pot" do
      expect(player.pot).to eq(1000)
    end
    it "Player#hand sets the empty hand" do
      expect(player.hand.cards).to be_empty
    end
  end

end
