require "open-uri"
require "json"

puts 'Cleaning database...'
Ingredient.destroy_all
Cocktail.destroy_all

url1 = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
ingredient_serialized = open(url1).read
ingredient = JSON.parse(ingredient_serialized)

ingredient['drinks'].each do |i|
  Ingredient.create!( name: i['strIngredient1'])
end

url2 = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
cocktail_serialized = open(url2).read
cocktail = JSON.parse(cocktail_serialized)

cocktail['drinks'].each do |i|
  Cocktail.create!( name: i['strDrink'])
end

puts 'Finished!'
