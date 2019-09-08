require "rails_helper"

describe "api view recipe details" do
  it "successfully" do
    recipe = create(:recipe)

    get "/api/v1/recipes/#{recipe.id}"

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 202
    expect(json_recipe[:title]).to eq recipe.title
  end

  it "and fails" do
    get "/api/v1/recipes/4457"

    expect(response.status).to eq 404
    expect(response.body).to include("Receita não encontrada")
  end
end
