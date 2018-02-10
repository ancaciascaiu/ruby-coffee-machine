
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

def quit
  exit
end

# def order_drink(drink_number)

# end

loop do
  user_input = gets.chomp

  restock(ingredients) if user_input.downcase == 'r'
  quit if user_input.downcase == 'q'
  # order_drink(user_input) if (1..6).cover?(user_input.to_i)
end
