require 'journey_log'

  describe JourneyLog do

    let(:card) { Oyster.new }
    let(:journey_log) { JourneyLog.new(card) }
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

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
        expect(journey_log.finish(exit_station)).to eq [{ entry: entry_station, exit: exit_station }]
      end
    end
  end
