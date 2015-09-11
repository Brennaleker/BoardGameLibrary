require 'rails_helper'

RSpec.describe BoardGame, type: :model do
  it "orders by ranking descending" do
    carcassone = BoardGame.create!(title: "Carcassone", rating: 12)
    sentinels = BoardGame.create!(title: "Sentinels of the Multiverse", rating: 24)

    expect(BoardGame.ordered_by_rating).to eq([sentinels, carcassone])
  end
end
