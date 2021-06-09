require 'journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:card) { Oyster.new }
  let(:journey) { Journey.new(card) }
  
  describe "#starting_journey" do
    it "touches in" do
      allow(card).to receive(:balance).and_return 10
      journey.touch_in(entry_station)
      expect(journey.in_journey?).to eq(true)
    end

    it "raises an error if card under £1" do
      allow(card).to receive(:balance).and_return 0.5
      expect{journey.touch_in(entry_station)}.to raise_error "Ops! Top it up!"
    end
  end

  describe "#ending_journey" do
      it "touches out" do
        allow(card).to receive(:balance).and_return 10
        journey.touch_out(exit_station)
        expect(journey.in_journey?).to eq(false)
      end

      it "charges the card when you touch out" do
        expect{ journey.touch_out(exit_station) }.to change(card, :balance).by(-1)
      end
  end

  describe "#in_journey" do
    before do
      allow(card).to receive(:balance).and_return 10
      journey.touch_in(entry_station)
    end

    it "check if in journey" do
      expect(journey).to be_in_journey
    end

    it "check if not in journey" do
      journey.touch_out(exit_station)
      expect(journey).not_to be_in_journey
    end
  end

  it "expects card to remember entry station" do
    allow(card).to receive(:balance).and_return 20
    expect(journey.touch_in(entry_station)).to eq entry_station
  end

  describe "#fare" do
    it "returns the correct the fare" do
      expect(journey.fare(entry_station, exit_station)).to eq 1
      expect(journey.fare(nil, exit_station)).to eq 6
      expect(journey.fare(entry_station, nil)).to eq 6
    end
  end
end