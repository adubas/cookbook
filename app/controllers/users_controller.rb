class UsersController < ApplicationController
  def my_recipes
    @recipes = current_user.recipes
    flash[:notice] = "Nenhuma receita cadastrada" if @recipes.empty?
  end

  def my_lists
    @recipe_lists = current_user.recipe_lists
    flash[:notice] = "Nenhuma lista cadastrada" if @recipe_lists.empty?
  end
end
