require 'rails_helper'

describe "Merchants API" do
  before :each do
    create_list(:merchant, 3)
    get '/api/v1/merchants'
    @merchants = JSON.parse(response.body)
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
end
