require "rails_helper"

FactoryBot.define do
  factory :recipe do
    sequence(:title) { |n| "Bolo de #{n}"}
    recipe_type
    cuisine
    difficulty { "média" }
    cook_time { "45" }
    ingredients { "alguns" }
    cook_method { "misturar tudo" }
    images { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/bolo_cenoura_01.jpg'), 'image/jpeg')}
    user
    status {:approved}
  end
end
