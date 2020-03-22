require 'rails_helper'

describe 'Merchant relationship with items' do
  it 'can return a list of items for a merchant' do
    merchant = create(:merchant)

    create_list(:item, 5, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].length).to eq(5)
  end
end
