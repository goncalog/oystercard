class Oyster

  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(money)
    fail "Oh no! You reached the max balance" if money + balance > MAX_BALANCE
    @balance = @balance + money
  end

  def touch_in(entry_station)
    raise "Ops! Top it up!" if balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journey_history.push({entry: @entry_station, exit: exit_station})
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  def deduct(money)
    @balance -= money
  end

end
