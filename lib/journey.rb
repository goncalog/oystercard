class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station

  def initialize(oystercard)
    @oystercard = oystercard
    @entry_station = nil
  end

  def touch_in(entry_station)
    raise "Ops! Top it up!" if @oystercard.balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @oystercard.deduct(fare(entry_station, exit_station))
    entry_station = @entry_station
    @entry_station = nil
    {entry: entry_station, exit: exit_station}
  end

  def in_journey?
    @entry_station != nil
  end

  def fare(entry_station , exit_station)
    if (entry_station == nil || exit_station == nil)
      PENALTY_FARE 
    else 
      MIN_FARE + (entry_station.zone - exit_station.zone).abs
    end
  end
end