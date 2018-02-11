require_relative '../lib/shopping_list.rb'

shoppingList = ShoppingList.new

shoppingList.listItems do
  add_item("Toothpaste", 2)
  add_item("Computer", 1)
  add_item("Mobile", 2)
  add_item("Washing Machine", 1)
  add_item("Toothpaste", 3)
end


shoppingList.viewList