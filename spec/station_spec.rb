require 'station'

describe Station do
  let(:station) { Station.new("Elephant and Castle", 1) }
  let(:card) { double :oyster }
  let(:entry_station) { double :entry_station, zone: 2 }
  let(:exit_station) { double :exit_station, zone: 2 }

  it "has a name" do
    expect(station.name).to eq "Elephant and Castle"
  end

  it "has a zone" do
    expect(station.zone).to eq 1
  end

  describe "#touch_in" do
    it "touches in" do
      allow(card).to receive(:balance).and_return 10
      allow(card).to receive_message_chain(:journey_log, :start).and_return true
      expect(card).to receive_message_chain(:journey_log, :start).with(station) 
      station.touch_in(card)
    end

    it "raises an error if card under £1" do
      allow(card).to receive(:balance).and_return 0.5
      expect{station.touch_in(card)}.to raise_error "Ops! Top it up!"
    end
  end

  describe "#touch_out" do
      it "touches out" do
        allow(card).to receive(:balance).and_return 10
        allow(card).to receive_message_chain(:journey_log, :start).and_return true
        station.touch_in(card)

        allow(card).to receive_message_chain(:journey_log, :current_journey, :entry_station).and_return station
        
        expect(card).to receive(:deduct).with(station.fare(station, station)) 
        expect(card).to receive_message_chain(:journey_log, :finish).with(station) 
        station.touch_out(card)
      end
  end

  describe "#fare" do
    context "when there's a penalty" do
      it "returns the correct the fare" do
        expect(station.fare(nil, exit_station)).to eq Station::PENALTY_FARE
        expect(station.fare(entry_station, nil)).to eq Station::PENALTY_FARE
      end
    end

    context "when there's no penalty" do
      it "returns the correct the fare for same zone" do
        allow(entry_station).to receive(:zone) { 2 }
        allow(exit_station).to receive(:zone) { 2 }
        expect(station.fare(entry_station, exit_station)).to eq Station::MIN_FARE
      end

      it "returns the correct the fare from zone 1 to 2" do
        allow(entry_station).to receive(:zone) { 1 }
        allow(exit_station).to receive(:zone) { 2 }
        expect(station.fare(entry_station, exit_station)).to eq (Station::MIN_FARE + 1)
      end

      it "returns the correct the fare from zone 2 to 1" do
        allow(entry_station).to receive(:zone) { 2 }
        allow(exit_station).to receive(:zone) { 1 }
        expect(station.fare(entry_station, exit_station)).to eq (Station::MIN_FARE + 1)
      end

      it "returns the correct the fare from zone 2 to 4" do
        allow(entry_station).to receive(:zone) { 2 }
        allow(exit_station).to receive(:zone) { 4 }
        expect(station.fare(entry_station, exit_station)).to eq (Station::MIN_FARE + 2)
      end

      it "returns the correct the fare from zone 5 to 1" do
        allow(entry_station).to receive(:zone) { 5 }
        allow(exit_station).to receive(:zone) { 1 }
        expect(station.fare(entry_station, exit_station)).to eq (Station::MIN_FARE + 4)
      end
    end    
  end

end