class Oyster
  
  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end


  def top_up(money)
    fail "Oh no! You reached the max balance" if money + balance > MAX_BALANCE
    @balance = @balance + money
  end

  
  def touch_in
    raise "Ops! Top it up!" if balance < MIN_FARE
    @in_use = true
  end
  
  def touch_out
    deduct(MIN_FARE)
    @in_use = false
  end
  
  def in_journey?
    @in_use
  end

  # private

  def deduct(money)
  @balance -= money
  end

end
