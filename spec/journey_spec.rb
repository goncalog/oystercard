require 'journey'

describe Journey do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { Journey.new(entry_station) }
  
  it "expects journey to remember entry station" do
    expect(journey.entry_station).to eq entry_station
  end

  it "expects journey to remember exit station" do
    journey.close(exit_station)
    expect(journey.exit_station).to eq exit_station
  end
end