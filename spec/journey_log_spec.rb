require 'journey_log'

  describe JourneyLog do
    let(:journey_log) { JourneyLog.new }
    let(:entry_station) { double :station, zone: 2 }
    let(:exit_station) { double :station, zone: 2 }

    describe '#start' do
      it 'starts a new journey with an entry station' do
        journey_log.start(entry_station)
        expect(journey_log.current_journey.entry_station).to eq entry_station
      end
    end

    describe '#finish' do
      it 'finishes a journey and adds an exit station' do
        journey_log.start(entry_station)
        journey_log.finish(exit_station)
        journey = journey_log.journeys.first
        expect(journey.exit_station).to eq exit_station
      end
    end

    it "has no an empty journey history on initialize" do
      expect(journey_log.journeys).to eq []
    end
    
    it "can record history of journeys" do
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      journey_log.start(exit_station)
      journey_log.finish(entry_station)

      journey_1 = journey_log.journeys.first
      journey_2 = journey_log.journeys.last
      
      expect(journey_1.entry_station).to eq entry_station
      expect(journey_1.exit_station).to eq exit_station
      expect(journey_2.entry_station).to eq exit_station
      expect(journey_2.exit_station).to eq entry_station
    end
  end
