require 'rails_helper'

describe 'Item relationship with a merchant' do
  it 'can return a merchant for an item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    merchant_json = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
