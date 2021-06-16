require 'oyster'
require 'station'
require 'journey_log'
require 'journey'

describe "#App" do
  angel = Station.new("Angel", 2)
  e_c = Station.new("Elephant and Castle", 1)
  royal_docks = Station.new("Royal Docks", 3)
  liverpool_street = Station.new("Liverpool Street", 1)

  card = Oyster.new
  card.top_up(20)

  angel.touch_in(card)
  e_c.touch_out(card)
  royal_docks.touch_in(card)
  liverpool_street.touch_out(card)
  
  it 'has correct balance' do
    expect(card.balance).to eq 15 # journeys cost £5 (2 + 3)
  end

  it 'has correct journey log' do
    journey_log = card.journey_log
    journey_1 = journey_log.journeys.first
    journey_2 = journey_log.journeys.last
    expect(journey_1.entry_station).to eq angel
    expect(journey_1.exit_station).to eq e_c
    expect(journey_2.entry_station).to eq royal_docks
    expect(journey_2.exit_station).to eq liverpool_street
  end
end