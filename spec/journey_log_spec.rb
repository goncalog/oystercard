require 'journey_log'

  describe JourneyLog do

    let(:card) { Oyster.new }
    let(:journey_log) { JourneyLog.new(card) }
    let(:entry_station) { double :station, zone: 2 }
    let(:exit_station) { double :station, zone: 2 }

    describe '#start' do
      it 'starts a new journey with an entry station' do
        card.top_up(10)
        expect(journey_log.start(entry_station)).to eq entry_station
      end
    end

    describe '#finish' do
      it 'finishes a journey and adds an exit station' do
        card.top_up(10)
        journey_log.start(entry_station)
        journey_log.finish(exit_station)
        expect(journey_log.journeys).to eq [{ entry: entry_station, exit: exit_station }]
      end
    end

    it "has no an empty journey history on initialize" do
      expect(journey_log.journeys).to eq []
    end
    
    it "can record history of journeys" do
      card.top_up(10)
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      journey_log.start(exit_station)
      journey_log.finish(entry_station)
      expect(journey_log.journeys).to eq [
          {entry: entry_station, exit: exit_station}, 
          {entry: exit_station, exit: entry_station},
        ]
    end
  end
