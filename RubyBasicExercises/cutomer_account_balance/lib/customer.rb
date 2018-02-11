class Customer
  @@account_number_counter = 0

  attr_reader :account_number, :balance, :customer_name

  def initialize(name)
    @@account_number_counter += 1
    @account_number, @balance, @name = @@account_number_counter, Float(1000), name
  end

  def deposit(amount)
    amount = amount.to_f
    if amount >= 0.0
      @balance += amount
    end
  end

  def withdraw(amount)
    amount = amount.to_f
    if amount < @balance && amount > 0.0
      @balance -= amount
    end
  end

  def to_s
    "#{ @name } #{ @account_number } #{ @balance}"
  end

end
