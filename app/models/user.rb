class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :recipes
  has_many :recipe_lists
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def my_recipes
  end
end
