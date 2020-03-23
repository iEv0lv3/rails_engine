require 'rails_helper'

RSpec.describe 'Merchants with the most revenue', type: :request do
  it 'can be displayed' do
    merchant1 = create(:merchant, name: 'Dota2 Shop')
    merchant2 = create(:merchant, name: 'The Swanson Connection')
    merchant3 = create(:merchant, name: 'Big Swag')
    merchant4 = create(:merchant, name: 'Cannabis Club')
    merchant5 = create(:merchant, name: 'Vegan Co-op')

    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant3)
    invoice4 = create(:invoice, merchant: merchant4)
    invoice5 = create(:invoice, merchant: merchant5)

    item1 = create(:item, unit_price: 10, merchant: merchant1)
    item2 = create(:item, unit_price: 15, merchant: merchant2)
    item3 = create(:item, unit_price: 20, merchant: merchant3)
    item4 = create(:item, unit_price: 25, merchant: merchant4)
    item5 = create(:item, unit_price: 30, merchant: merchant5)

    invoice_items1 = create(:invoice_item, unit_price: 10, invoice: invoice1, item: item1, quantity: 10)
    invoice_items2 = create(:invoice_item, unit_price: 15, invoice: invoice2, item: item2, quantity: 10)
    invoice_items3 = create(:invoice_item, unit_price: 20, invoice: invoice3, item: item3, quantity: 10)
    invoice_items4 = create(:invoice_item, unit_price: 25, invoice: invoice4, item: item4, quantity: 10)
    invoice_items5 = create(:invoice_item, unit_price: 30, invoice: invoice5, item: item5, quantity: 10)

    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice3)
    transaction4 = create(:transaction, invoice: invoice4)
    transaction5 = create(:transaction, invoice: invoice5)

    get "/api/v1/merchants/most_revenue?quantity=5"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(5)
    expect(merchants[:data].first[:attributes][:name]).to eq('Vegan Co-op')
    expect(merchants[:data].last[:attributes][:name]).to eq('Dota2 Shop')
  end
end
