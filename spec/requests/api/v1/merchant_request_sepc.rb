require 'rails_helper'

describe "Merchants API" do
  before :each do
    create_list(:merchant, 3)
    get '/api/v1/merchants'
    @merchants = JSON.parse(response.body)

    @merchant1 = @merchants['data'][0]
    get "/api/v1/merchants/#{@merchant1["id"]}"
    @merchant1_body = JSON.parse(response.body)
  end

  it "Sends a list of merchants" do
    expect(response).to be_successful
    expect(@merchants["data"].count).to eq(3)
  end

  it "Merchant data is serialized as expected" do
    merchant1 = @merchants['data'][0]
    merchant2 = @merchants['data'][1]
    merchant3 = @merchants['data'][2]

    expect(@merchants['data'][0]["id"]).to eq(merchant1["id"])
    expect(@merchants['data'][0]["name"]).to eq(merchant1["name"])
    expect(@merchants['data'][0]["type"]).to eq("merchant")

    expect(@merchants['data'][1]["id"]).to eq(merchant2["id"])
    expect(@merchants['data'][1]["name"]).to eq(merchant2["name"])
    expect(@merchants['data'][1]["type"]).to eq("merchant")

    expect(@merchants['data'][2]["id"]).to eq(merchant3["id"])
    expect(@merchants['data'][2]["name"]).to eq(merchant3["name"])
    expect(@merchants['data'][2]["type"]).to eq("merchant")
  end

  it "Merchant show data is serialized as expected" do
    expect(@merchant1_body['data']['name']).to eq(@merchant1['name'])
  end

  it "A new Merchant can be created" do
    merchant_params = { name: "Dota2 Shop" }
    post "/api/v1/merchants", params: { merchant: merchant_params }

    expect(response).to be_successful
    merchant = Merchant.last
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "A Merchant can be updated" do
    merchant = create(:merchant, name: "Dota2 Shop")
    expect(merchant.name).to eq("Dota2 Shop")
    merchant_params = { name: "Dota3 Shop" }

    patch "/api/v1/merchants/#{merchant.id}", params: { merchant: merchant_params }

    expect(response).to be_successful
    updated_merchant = Merchant.find(merchant.id)
    expect(updated_merchant.name).to eq("Dota3 Shop")
  end

  it "A Merchant can be deleted" do
    merchant = create(:merchant)
    expect(Merchant.all.count).to eq(4)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.all.count).to eq(3)
    expect { Merchant.find(merchant.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
