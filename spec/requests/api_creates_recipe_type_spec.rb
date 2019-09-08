require "rails_helper"

describe "api creates recipe type" do
  it "successfully" do
    user = create(:user)
    sign_in user

    post "/api/v1/recipe_types", params: { recipe_type: { name: "Prato Principal" } }

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201
    expect(json_recipe_type[:name]).to eq "Prato Principal"
  end

  it "but must fill all fields" do
    user = create(:user)
    sign_in user

    post "/api/v1/recipe_types", params: { recipe_type: { name: "" } }

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_recipe_type[:msg]).to include("Não foi possível criar esse tipo de receita")
    expect(json_recipe_type[:error_type]).to include("Nome do tipo de Receita não pode ficar em branco")
  end

  it "but it must be unique" do
    user = create(:user)
    sign_in user

    recipe_type = create(:recipe_type, name: "Sobremesa")

    post "/api/v1/recipe_types", params: { recipe_type: { name: "Sobremesa" } }

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_recipe_type[:msg]).to include("Não foi possível criar esse tipo de receita")
    expect(json_recipe_type[:error_type]).to include("Nome do tipo de Receita já está em uso")
  end
end
