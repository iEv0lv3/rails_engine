require 'rails_helper'

describe 'When I search for a Merchant by name' do
  it 'it returns a single merchant' do
    merchant1 = create(:merchant, name: "Swag Shop")
    merchant2 = create(:merchant, name: "The Swanson Shop")
    merchant3 = create(:merchant, name: "Dota2 Shop")

    get "/api/v1/merchants/find?name=swag"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)["data"]

    expect(merchant["attributes"]["name"]).to eq("Swag Shop")
    expect(merchant["id"]).to eq("#{merchant1.id}")
  end
end

describe 'When I search for a Merchant by multiple parameters' do
  it 'it returns a single merchant' do
    merchant1 = create(:merchant, name: "Swag Shop")
    merchant2 = create(:merchant, name: "The Swanson Shop")
    merchant3 = create(:merchant, name: "Dota2 Shop")

    get "/api/v1/merchants/find?name=swag&created_at=#{merchant1.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]
    expect(merchant["attributes"]["name"]).to eq("Swag Shop")
    expect(merchant["id"]).to eq("#{merchant1.id}")
  end
end

describe 'When I search for a Merchant with find_all' do
  it 'it returns all matching merchants' do
    merchant1 = create(:merchant, name: "Swag Shop")
    merchant2 = create(:merchant, name: "The Swanson Shop")
    merchant3 = create(:merchant, name: "Dota2 Shop")

    get "/api/v1/merchants/find_all?name=swa"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]

    expect(merchants.size).to eq(2)
    expect(merchants[0]["id"]).to eq(merchant1.id.to_s)
    expect(merchants[1]["id"]).to eq(merchant2.id.to_s)

    get "/api/v1/merchants/find_all?name=electric_bugaloo"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)["data"]
    expect(merchants.size).to eq(0)
  end
end
