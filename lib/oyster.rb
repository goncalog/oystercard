class Oyster

  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(money)
    fail "Oh no! You reached the max balance" if money + balance > MAX_BALANCE
    @balance = @balance + money
  end

  def deduct(money)
    @balance -= money
  end
end
