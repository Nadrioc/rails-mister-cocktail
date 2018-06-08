
require 'open-uri'

p "Cleaning database..."
Cocktail.destroy_all
Dose.destroy_all

p "Adding shit"

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'

json_hash = JSON.parse(open(url).read)

json_hash['drinks'].each do |drink|
  cocktail = Cocktail.create!({
    name: drink['strDrink'],
    image: drink["strDrinkThumb"],
  })
  jh = JSON.parse(open("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink["idDrink"]}").read)
  drink = jh["drinks"][0]
  i = 1
  while i <= 15
    ing_name = drink["strIngredient#{i}"]
    desc = drink["strMeasure#{i}"]
    break if ing_name == ""
    ingredient = Ingredient.find_by(name: ing_name)
    if ingredient
      Dose.create!({
        cocktail: cocktail,
        ingredient: ingredient,
        description: desc,
      })
    end
    i += 1
  end
end

p "Finished!"
