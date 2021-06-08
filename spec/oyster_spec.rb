require "./lib/oyster"

describe Oyster do

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


end