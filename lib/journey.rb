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
    @oystercard.deduct(MIN_FARE)
    @oystercard.journey_history.push({entry: @entry_station, exit: exit_station})
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  def fare(entry_station , exit_station)
    (entry_station == nil || exit_station == nil) ? PENALTY_FARE : MIN_FARE
  end
end