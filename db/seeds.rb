# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

user = User.create(email: "one@email.com", password: "457856", admin: false)
another_user = User.create(email: "two@email.com", password: "558877", admin: false)
admin = User.create(email: "admin@email.com", password: "589965", admin: true)

recipe_type = RecipeType.create!(name: "Prato Principal")
another_recipe_type = RecipeType.create!(name: "Bebidas")
spare_recipe_type = RecipeType.create!(name: "Sobremesa")

cuisine = Cuisine.create!(name: "Polonesa")
another_cuisine = Cuisine.create!(name: "Brasileira")
spare_cuisine = Cuisine.create!(name: "Italiana")

pierogui = Recipe.create!(title: "Pierogui", recipe_type: recipe_type, cuisine: cuisine,
                          difficulty: "Média", cook_time: 120,
                          ingredients: "Massa - farinha, água e sal. Recheio - batata e ricota. Molho - creme de leite e ricota",
                          cook_method: "Faça uma massa, com ela faça pequenos pastéis recheados com a batata e ricota, cozinhe-os e sirva o molho.",
                          user: user, status: :approved)
hot_chocolate = Recipe.create!(title: "Chocolate quente", recipe_type: another_recipe_type, cuisine: another_cuisine,
                               difficulty: "Fácil", cook_time: 15,
                               ingredients: "Leite, creme de leite e chocolate em pó",
                               cook_method: "Ferva tudo", user: admin, status: :approved)
pizza = Recipe.create!(title: "Pizza", recipe_type: recipe_type, cuisine: spare_cuisine,
                       difficulty: "Difícil", cook_time: 60,
                       ingredients: "Massa de pizza, queijo, tomate e molho de tomate",
                       cook_method: "Abrir a massa, colocar o molho de tomate, queijo e tomate, e colocar no forno",
                       user: another_user, status: :pending)
carrot_cake = Recipe.create!(title: "Bolo de cenoura", recipe_type: spare_recipe_type, cuisine: another_cuisine,
                             difficulty: "Fácil", cook_time: 45,
                             ingredients: "Farinha, ovos, leite e cenoura",
                             cook_method: "Misture tudo e asse.", user: user, status: :approved)
