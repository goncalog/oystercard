class Station
  attr_reader :name, :zone
  MIN_FARE = 1
  PENALTY_FARE = 6
  
  def initialize(name, zone)
    @name = name
    @zone = zone
  end

  def touch_in(card)
    raise "Ops! Top it up!" if card.balance < MIN_FARE
    card.journey_log.start(self)
  end

  def touch_out(card)
    entry_station = card.journey_log.current_journey.entry_station
    card.deduct(fare(entry_station, self))

    card.journey_log.finish(self)
  end

  def fare(entry_station, exit_station)
    if (entry_station == nil || exit_station == nil)
      PENALTY_FARE 
    else 
      MIN_FARE + (entry_station.zone - exit_station.zone).abs
    end
  end
end