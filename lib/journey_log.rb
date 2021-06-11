class JourneyLog

  def initialize(oystercard, journey_class = Journey)
    @journey_class = journey_class
    @oystercard = oystercard
    @current_journey = nil
  end

  def start(entry_station)
    @current_journey = current_journey
    @current_journey.touch_in(entry_station)
  end

  def finish(exit_station)
    @current_journey.touch_out(exit_station)
  end

  private
  def current_journey
    if @current_journey == nil
      @journey_class.new(@oystercard)
    else 
      @current_journey
    end
  end
end
