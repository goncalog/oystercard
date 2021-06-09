require "./lib/oyster"

describe Oyster do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it "balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it "top up card" do
      expect{subject.top_up(2)}.to change(subject, :balance).by(2)
    end

    it "gives an error if card reaches max balance" do
      max_balance = Oyster::MAX_BALANCE
      subject.top_up(max_balance)
      expect{subject.top_up(1)}.to raise_error "Oh no! You reached the max balance"
    end
  end

  describe "#deduct" do
    it "deducts money" do
      subject.top_up(10)
      expect(subject.deduct(3)).to eq 7
    end
  end

  describe "#starting_journey" do
    it "touches in" do
      allow(subject).to receive(:balance).and_return 10
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq(true)
    end

    it "raises an error if card under £1" do
      allow(subject).to receive(:balance).and_return 0.5
      expect{subject.touch_in(entry_station)}.to raise_error "Ops! Top it up!"
    end
  end

  describe "#ending_journey" do
      it "touches out" do
        allow(subject).to receive(:balance).and_return 10
        subject.touch_out(exit_station)
        expect(subject.in_journey?).to eq(false)
      end

      it "charges the card when you touch out" do
        expect{ subject.touch_out(exit_station) }.to change(subject, :balance).by(-1)
      end
  end

  describe "#in_journey" do
    before do
      allow(subject).to receive(:balance).and_return 10
      subject.touch_in(entry_station)
    end
    it "check if in journey" do
      expect(subject).to be_in_journey
    end

    it "check if not in journey" do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
  end

  describe '#journey_log' do
    before do
      allow(subject).to receive(:balance).and_return 20
    end

    it "expects card to remember entry station" do
      expect(subject.touch_in(entry_station)).to eq entry_station
    end

    it "can record history of journeys" do
      subject.touch_in("Angel")
      subject.touch_out("Elephant and Castle")
      subject.touch_in("Royal Docks")
      subject.touch_out("Liverpool Street")
      expect(subject.journey_history).to eq [{entry: "Angel", exit: "Elephant and Castle"}, {entry: "Royal Docks", exit: "Liverpool Street"}]
    end

    it "expects a new card to have no journey history" do
      expect(subject.journey_history).to eq []
    end
  end

end
