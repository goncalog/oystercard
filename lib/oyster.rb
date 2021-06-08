class Oyster
  
  MAX_BALANCE = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end


  def top_up(money)
    @balance = @balance + money 
    fail "Oh no! You reached the max balance" if money + balance > MAX_BALANCE
  end

end