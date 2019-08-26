class RecipeType < ApplicationRecord
    has_many :recipes

    validates :name, presence: {message: 'Você deve preencher o campo nome'}
    validates :name, uniqueness: {case_sensitive: false, message: 'Tipo de receita já cadastrado'}
end
