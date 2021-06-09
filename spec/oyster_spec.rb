require "oyster"

describe Oyster do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:card) { Oyster.new }
  let(:journey) { Journey.new(card) }

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

  describe '#journey_log' do
    before do
      allow(card).to receive(:balance).and_return 20
    end

    it "can record history of journeys" do
      journey.touch_in("Angel")
      journey.touch_out("Elephant and Castle")
      journey.touch_in("Royal Docks")
      journey.touch_out("Liverpool Street")
      expect(card.journey_history).to eq [{entry: "Angel", exit: "Elephant and Castle"}, {entry: "Royal Docks", exit: "Liverpool Street"}]
    end

    it "expects a new card to have no journey history" do
      expect(card.journey_history).to eq []
    end
  end

end
