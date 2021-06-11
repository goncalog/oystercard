require 'journey_log'

  describe JourneyLog do

    let(:card) { Oyster.new }
    let(:journey_log) { JourneyLog.new(card) }
    let(:entry_station) { double :station }

    describe '#start' do
      it 'starts a new journey with an entry station' do
        card.top_up(10)
        expect(journey_log.start(entry_station)).to eq entry_station
      end
    end

  end
