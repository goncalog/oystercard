require 'journey_log'

  describe JourneyLog do

    let(:journey_log) { JourneyLog.new }
    let(:entry_station) { double :station }
    # let(:journey) { Journey.new }
    # let(:card) { Oyster.new }

    describe '#start' do
      it 'starts a new journey with an entry station' do
        expect(journey_log.start(entry_station)).to eq entry_station
      end
    end

  end
