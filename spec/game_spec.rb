require "game"

describe Game do
  let(:game) { Game.new }

  describe "Game#initialize" do
    it "sets up the deck" do
      expect(game.deck.deck_size).to eq(52)
    end

    it "has players" do
      expect(game.players).to be_a(Array)
    end
    it "has a player" do
      expect(game.players.first).to be_a(Player)
    end
    it "has a pot " do
      expect(game.pot).to eq(0)
    end
    it "has a current player " do
      expect(game.current_player).to be_a(Player)
    end
  end

end
