# this is the runner file for the Object Oriented version of the Coffee Machine

class CoffeeMachine
  attr_reader :ingredients, :drink_recipes, :user_input, :inventory, :dispenser

  def initialize(ingredients:, drink_recipes:)
    @ingredients   = ingredients
    @drink_recipes = drink_recipes
    @inventory     = Inventory.new(ingredients: ingredients, drink_recipes: drink_recipes)
    @dispenser     = Dispenser.new(ingredients: ingredients, drink_recipes: drink_recipes)
  end

  def start
    loop do
      inventory.display_inventory
      dispenser.display_menu
      @user_input = gets.chomp
      handle_input
    end
  end

  private

  def handle_input
    inventory.restock if valid_restock_input
    exit if valid_quit_input
    dispense_drink if valid_order_input
    puts "Invalid Selection: #{user_input}" if invalid_user_input
  end

  def valid_restock_input
    user_input.downcase == 'r'
  end

  def valid_quit_input
    user_input.downcase == 'q'
  end

  def valid_order_input
    (1..drink_recipes.count).cover?(user_input.to_i)
  end

  def invalid_user_input
    !valid_restock_input &&
      !valid_quit_input &&
      !valid_order_input
  end

  def dispense_drink
    inventory.update(user_input) if dispenser.order_drink(user_input)
  end
end

class Inventory
  attr_reader :ingredients, :drink_recipes

  def initialize(ingredients:, drink_recipes:)
    @ingredients   = ingredients
    @drink_recipes = drink_recipes
  end

  def restock
    ingredients.each { |_ingredient, value| value[:units] = 10 }
    puts 'Restocked!'
  end

  def update(drink_number)
    drink_name = drink_recipes.keys[drink_number.to_i - 1]
    drink_recipes[drink_name].each do |ingredient, qty|
      ingredients[ingredient][:units] -= qty
    end
  end

  def display_inventory
    puts 'Inventory: '
    ingredients.each do |ingredient, details|
      puts "#{ingredient}, #{details[:units]} units"
    end
  end
end

class Dispenser
  attr_reader :ingredients, :drink_recipes, :drink_name

  def initialize(ingredients:, drink_recipes:)
    @ingredients   = ingredients
    @drink_recipes = drink_recipes
  end

  def order_drink(drink_number)
    @drink_name = drink_recipes.keys[drink_number.to_i - 1]
    if can_make_drink?
      puts "Dispensing: #{drink_name} "
      true
    else
      puts "Out of stock: #{drink_name}"
    end
  end

  def display_menu
    puts 'Menu: '
    drink_recipes.each_with_index do |drink, index|
      @drink_name = drink[0]
      puts "Nr. #{index + 1}, #{drink_name}, $#{cost}, #{in_stock?}"
    end
  end

  private

  def can_make_drink?
    drink_recipes[drink_name].each do |ingredient, qty|
      return false if ingredients[ingredient][:units] < qty
    end
    true
  end

  def cost
    cost = 0
    drink_recipes[drink_name].each do |ingredient, qty|
      cost += ingredients[ingredient][:price] * qty
    end
    cost.round(2)
  end

  def in_stock?
    if can_make_drink?
      'in-stock'
    else
      'out-of-stock'
    end
  end
end

# instead of using a database:
ingredients = {
  coffee:        { price: 0.75, units: 10 },
  decaf_coffee:  { price: 0.75, units: 10 },
  sugar:         { price: 0.25, units: 10 },
  cream:         { price: 0.25, units: 10 },
  steamed_milk:  { price: 0.35, units: 10 },
  foamed_milk:   { price: 0.35, units: 10 },
  espresso:      { price: 1.10, units: 10 },
  cocoa:         { price: 0.90, units: 10 },
  whipped_cream: { price: 1.00, units: 10 }
}

drink_recipes = {
  regular_coffee:  { coffee: 3, sugar: 1, cream: 1 },
  decaf_coffee:    { decaf_coffee: 3, sugar: 1, cream: 1 },
  caffe_latte:     { espresso: 2, steamed_milk: 1 },
  caffe_americano: { espresso: 2 },
  caffe_mocha:     { espresso: 1, cocoa: 1, steamed_milk: 1, whipped_cream: 1 },
  cappucino:       { espresso: 2, steamed_milk: 1, foamed_milk: 1 }
}

machine = CoffeeMachine.new(ingredients: ingredients,
                            drink_recipes: drink_recipes)
machine.start
