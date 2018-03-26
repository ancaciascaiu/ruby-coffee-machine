# new learning: when designing an object oriented program,
  # start from the smallest real life object that you can detect in the requirements.
  # For this exercise we have ingredient.


class Ingredient
  def initialize
    @price
    @units
  end
end

class Coffee < Ingredient
end

class RawDecafCoffee < Ingredient
end

class Sugar < Ingredient
end

class Cream < Ingredient
end

class SteamedMilk < Ingredient
end

class FoamedMilk < Ingredient
end

class Espresso < Ingredient
end

class Cocoa < Ingredient
end

class WhippedCream < Ingredient
end

# then we have coffee drinks:
class Drink
  def initialize
    @ingredients
    @quantity
  end
end

class RegularCoffee < Drink
end

class DecafCoffee < Drink
end

class CaffeeLatte < Drink
end

class CaffeeAmericano < Drink
end

class CaffeeMocha < Drink
end

class Cappucino < Drink
end

# we have an object responsible with the Inventory management:
class InventoryManager
end

# we need a Coffee dispenser
class CoffeeDispenser
end

# we need a runner:
class CoffeeMachine
  def run
  end
end

CoffeeMachine.new.run

