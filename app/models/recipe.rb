class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :recipe_type
  belongs_to :cuisine

  has_many :recipe_list_items
  has_many :recipe_lists, through: :recipe_list_items

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true
  validates :title, uniqueness: { scope: :user_id }

  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
    self.user == user
  end
end
