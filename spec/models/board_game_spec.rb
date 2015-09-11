require 'rails_helper'

RSpec.describe BoardGame, type: :model do
  it "orders by title ascending" do
    carcassone = BoardGame.create!(title: "Carcassone")
    sentinels = BoardGame.create!(title: "Sentinels of the Multiverse")

    expect(BoardGame.ordered_by_rating).to eq([carcassone, sentinels])
  end
end
