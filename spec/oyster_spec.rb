require "./lib/oyster"

describe Oyster do

  # let(:station) { Station.new }
  it "balance of 0" do
    expect(subject.balance).to eq(0)
  end

  # it { is_expected.to respond_to(:top_up).with(1).argument }

  # it "top up card" do
  #   expect{subject.top_up(2)}.to change(subject, :balance).by(2)
  # end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
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
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it "deducts money" do
      subject.top_up(10)
      expect(subject.deduct(3)).to eq 7
    end
  end

  
  it { is_expected.to respond_to(:touch_out) }
  it { is_expected.to respond_to(:in_journey?) }

  describe "#touch_in" do

  it { is_expected.to respond_to(:touch_in) }
  it "touches in" do
    allow(subject).to receive(:balance).and_return 10
    expect(subject.touch_in).to eq(true)
  end
  it "raises an error if card under £1" do
  allow(subject).to receive(:balance).and_return 0.5
  expect{subject.touch_in}.to raise_error "Ops! Top it up!"
  end

end

  it "touches out" do
    allow(subject).to receive(:balance).and_return 10
    expect(subject.touch_out).to eq(false)
  end
 
  it "check if in journey" do
    allow(subject).to receive(:balance).and_return 10
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "check if not in journey" do
    allow(subject).to receive(:balance).and_return 10
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it "charges the card when you touch out" do
    expect{ subject.touch_out }.to change(subject, :balance).by(-1)
  end

  # expect{subject.top_up(2)}.to change(subject, :balance).by(2)

end