class Oyster

  MAX_BALANCE = 90
  attr_reader :balance, :journey_log

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(money)
    fail "Oh no! You reached the max balance" if money + balance > MAX_BALANCE
    @balance = @balance + money
  end

  def deduct(money)
    @balance -= money
  end
end
