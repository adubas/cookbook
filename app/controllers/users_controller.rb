class UsersController < ApplicationController
    def my_recipes
        @recipes = current_user.recipes
        flash[:notice]= 'Nenhuma receita cadastrada' if @recipes.empty?
    end
end
