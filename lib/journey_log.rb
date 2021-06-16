class JourneyLog
  attr_reader :journeys, :current_journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil
    @journeys = []
  end

  def start(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def finish(exit_station)
    @current_journey.close(exit_station)
    @journeys << @current_journey
    @current_journey = nil
  end
end
