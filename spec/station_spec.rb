require 'station'

describe Station do
  let(:station) { Station.new("Elephant and Castle", 1) }

  it "has a name" do
    expect(station.name).to eq "Elephant and Castle"
  end

  it "has a zone" do
    expect(station.zone).to eq 1
  end
end