# this is the runner file for the Object Oriented version of the Coffee Machine

class CoffeeMachine
  attr_reader :ingredients, :user_input

  def initialize(ingredients:)
    @ingredients = ingredients
  end

  def start
    loop do
      p "started!"
      # print_inventory
      # print_menu
      @user_input = gets.chomp
      handle_input
    end
  end

  private

  def handle_input
    restock if valid_restock_input
    exit if valid_quit_input
    order_drink if valid_order_input
    puts "Invalid Selection: #{user_input}" if invalid_user_input
  end

  def restock
    ingredients.each { |_ingredient, value| value[:units] = 10 }
    puts 'Restocked!'
  end

  def valid_restock_input
    user_input.downcase == 'r'
  end

  def valid_quit_input
    user_input.downcase == 'q'
  end

  def order_drink

  end

  def valid_order_input
    # !!!can I not rely on 6 as a number of drinks and use the count of drinks?
    (1..6).cover?(user_input.to_i)
  end

  def invalid_user_input
    !valid_restock_input &&
      !valid_quit_input &&
      !valid_order_input
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

drinks = {
  regular_coffee:  { coffee: 3, sugar: 1, cream: 1 },
  decaf_coffee:    { decaf_coffee: 3, sugar: 1, cream: 1 },
  caffe_latte:     { espresso: 2, steamed_milk: 1 },
  caffe_americano: { espresso: 2 },
  caffe_mocha:     { espresso: 1, cocoa: 1, steamed_milk: 1, whipped_cream: 1 },
  cappucino:       { espresso: 2, steamed_milk: 1, foamed_milk: 1 }
}

CoffeeMachine.new(ingredients: ingredients).start
