class JourneyLog

  def initialize(journey_class = Journey, oystercard)
    @journey_class = journey_class
    @oystercard = oystercard
  end

  def start(entry_station)
    current_journey = @journey_class.new(@oystercard)
    current_journey.touch_in(entry_station)
  end

end
