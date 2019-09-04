class Recipe < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 9 }

  belongs_to :user
  belongs_to :recipe_type
  belongs_to :cuisine

  has_many :recipe_list_items
  has_many :recipe_lists, through: :recipe_list_items

  has_many_attached :images

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method, presence: true
  validates :title, uniqueness: { scope: :user_id }

  def cook_time_min
    "#{cook_time} minutos"
  end

  def owner?(user)
    self.user == user
  end
end
