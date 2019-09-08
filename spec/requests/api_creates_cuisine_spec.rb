require "rails_helper"

describe "api creates cuisine" do
  it "successfully" do
    user = create(:user)
    sign_in user

    post "/api/v1/cuisines", params: {cuisine: { name: "Polonesa" } }

    json_cuisine = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201
    expect(json_cuisine[:name]).to eq "Polonesa"
  end

  it "but must fill all fields" do
    user = create(:user)
    sign_in user

    post "/api/v1/cuisines", params: { cuisine: { name: "" } }

    json_cuisine = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_cuisine[:msg]).to include("Não foi possível criar essa cozinha")
    expect(json_cuisine[:error_type]).to include("Tipo de Cozinha não pode ficar em branco")
  end

  it "but must be unique" do
    user = create(:user)
    sign_in user
    
    cuisine = create(:cuisine, name: "polonesa")

    post "/api/v1/cuisines", params: { cuisine: { name: "Polonesa" } }

    json_cuisine = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    expect(json_cuisine[:msg]).to include("Não foi possível criar essa cozinha")
    expect(json_cuisine[:error_type]).to include("Tipo de Cozinha já está em uso")
  end
end
