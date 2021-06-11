require "oyster"

describe Oyster do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:card) { Oyster.new }

  it "balance of 0" do
    expect(card.balance).to eq(0)
  end

  describe "#top_up" do
    it "top up card" do
      expect{card.top_up(2)}.to change(card, :balance).by(2)
    end

    it "gives an error if card reaches max balance" do
      max_balance = Oyster::MAX_BALANCE
      card.top_up(max_balance)
      expect{card.top_up(1)}.to raise_error "Oh no! You reached the max balance"
    end
  end

  describe "#deduct" do
    it "deducts money" do
      card.top_up(10)
      expect(card.deduct(3)).to eq 7
    end
  end
end
