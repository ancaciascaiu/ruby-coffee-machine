
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

def restock(ingredients)
  ingredients.each { |ingredient, value| value[:units] = 10 }
  puts 'Restocked!'
end

def order_drink(drinks, ingredients, drink_number)
  keys = drinks.keys
  drink_name = keys[drink_number.to_i - 1]
  drink = drinks[drink_name]
  if can_make_drink?(drink, ingredients)
    puts "Dispensing: #{drink_name} "
    update_inventory(drink, ingredients)
  else
    puts "Out of stock: #{drink_name}"
  end
end

def can_make_drink?(drink, ingredients)
  drink.each do |ingredient, qty|
    return false if ingredients[ingredient][:units] < qty
  end
  true
end

def update_inventory(drink, ingredients)
  drink.each do |ingredient, qty|
    ingredients[ingredient][:units] -= qty
  end
end

def display_inventory(ingredients)
  puts "Inventory: "
  ingredients.each do |ingredient, details|
    puts "#{ingredient}, #{details[:units]} units"
  end
end

def display_menu(drinks, ingredients)
  puts "Menu: "
  drinks.each_with_index do |drink, index|
    drink_name = drink[0]
    puts "Nr. #{index + 1}, #{drink_name}, $#{cost(ingredients, drinks, drink_name)}, #{in_stock?(ingredients, drinks, drink_name)}"
  end
end

def cost(ingredients, drinks, drink)
  p drink
  cost = 0
  drinks[drink].each do |ingredient, qty|
    cost += ingredients[ingredient][:price] * qty
  end
  cost.round(2)
end

def in_stock?(ingredients, drinks, drink)
  if can_make_drink?(drinks[drink], ingredients)
    'in-stock'
  else
    'out-of-stock'
  end
end

def valid_restock_input(user_input)
  user_input.downcase == 'r'
end

def valid_quit_input(user_input)
  user_input.downcase == 'q'
end

def valid_order_input(user_input)
  (1..6).cover?(user_input.to_i)
end

def invalid_user_input(user_input)
  !valid_restock_input(user_input) &&
    !valid_quit_input(user_input) &&
    !valid_order_input(user_input)
end

loop do
  display_inventory(ingredients)
  display_menu(drinks, ingredients)
  user_input = gets.chomp

  restock(ingredients) if valid_restock_input(user_input)
  exit if valid_quit_input(user_input)
  order_drink(drinks, ingredients, user_input) if valid_order_input(user_input)
  puts "Invalid Selection: #{ user_input }" if invalid_user_input(user_input)
end
