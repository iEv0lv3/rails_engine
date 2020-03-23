require 'rails_helper'

describe 'When I search for a Item by name' do
  it 'it returns a single Item' do
    merchant = create(:merchant, name: "Dota2 Shop")
    item1 = create(:item, name: "Blink Dagger", unit_price: 95.00, merchant: merchant)
    item2 = create(:item, name: "Eul's Sceptre", unit_price: 115.00, merchant: merchant)
    item3 = create(:item, name: "Atos Sceptre", unit_price: 105.00, merchant: merchant)

    get "/api/v1/items/find?name=blink"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]

    expect(item["attributes"]["name"]).to eq("Blink Dagger")
    expect(item["id"]).to eq("#{item1.id}")

    get "/api/v1/items/find?unit_price=105.00"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]
    expect(item["attributes"]["unit_price"]).to eq(item3.unit_price)
  end
end

describe 'When I search for a item by multiple parameters' do
  it 'it returns a single item' do
    merchant = create(:merchant, name: "Dota2 Shop")
    item1 = create(:item, name: "Blink Dagger", description: "Over here", merchant: merchant)
    item2 = create(:item, name: "Eul's Sceptre", description: "Up you go", merchant: merchant)
    item3 = create(:item, name: "Atos Sceptre", description: "Rooted you are", merchant: merchant)

    get "/api/v1/items/find?name=blink&created_at=#{item1.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]
    expect(item["attributes"]["name"]).to eq("Blink Dagger")
    expect(item["id"]).to eq("#{item1.id}")

    get "/api/v1/items/find?name=scep&description=you"

    expect(response).to be_successful
    item = JSON.parse(response.body)["data"]
    expect(item["attributes"]["description"]).to eq("Up you go")
    expect(item["id"]).to eq("#{item2.id}")
  end
end

describe 'When I search for a item with find_all' do
  it 'it returns all matching items' do
    merchant = create(:merchant, name: "Dota2 Shop")
    item1 = create(:item, name: "Blink Dagger", merchant: merchant)
    item2 = create(:item, name: "Eul's Sceptre", merchant: merchant)
    item3 = create(:item, name: "Atos Sceptre", merchant: merchant)

    get "/api/v1/items/find_all?name=scep"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.size).to eq(2)
    expect(items[1]["id"]).to eq(item2.id.to_s)
    expect(items[0]["id"]).to eq(item3.id.to_s)

    get "/api/v1/items/find_all?name=electric_bugaloo"

    expect(response).to be_successful
    items = JSON.parse(response.body)["data"]
    expect(items.size).to eq(0)
  end
end
