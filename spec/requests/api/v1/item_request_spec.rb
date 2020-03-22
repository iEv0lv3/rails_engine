require 'rails_helper'

describe "Items API" do
  before :each do
    create_list(:item, 3)
    get '/api/v1/items'
    @items = JSON.parse(response.body)

    @item1 = @items['data'][0]
    get "/api/v1/items/#{@item1["id"]}"
    @item1_body = JSON.parse(response.body)
  end

  it "Sends a list of items" do
    expect(response).to be_successful
    expect(@items["data"].count).to eq(3)
  end

  it "Items index data is serialized as expected" do
    item1 = @items['data'][0]
    item2 = @items['data'][1]
    item3 = @items['data'][2]

    expect(@items['data'][0]["id"]).to eq(item1["id"])
    expect(@items['data'][0]["name"]).to eq(item1["name"])
    expect(@items['data'][0]["type"]).to eq("item")

    expect(@items['data'][1]["id"]).to eq(item2["id"])
    expect(@items['data'][1]["name"]).to eq(item2["name"])
    expect(@items['data'][1]["type"]).to eq("item")

    expect(@items['data'][2]["id"]).to eq(item3["id"])
    expect(@items['data'][2]["name"]).to eq(item3["name"])
    expect(@items['data'][2]["type"]).to eq("item")
  end

  it "Item show data is serialized as expected" do
    expect(@item1_body['data']['name']).to eq(@item1['name'])
    expect(@item1_body['data']['desciption']).to eq(@item1['description'])
    expect(@item1_body['data']['unit_price']).to eq(@item1['unit_price'])
    expect(@item1_body['data']['merchant_id']).to eq(@item1['merchant_id'])
  end

  it "A new Item can be created" do
    merchant = create(:merchant)
    create_list(:item, 2, merchant: merchant)
    item_params = { name: "coffee", description: "jamacian me crazy", unit_price: "16", merchant_id: merchant.id }
    post "/api/v1/items", params: { item: item_params }

    expect(response).to be_successful
    my_item = Item.last 
    expect(my_item.name).to eq(item_params[:name])
  end

  it "An Item can be updated" do
    merchant = create(:merchant)
    item = create(:item, name: 'volkl98', merchant: merchant)
    expect(item.name).to eq("volkl98")
    item_params = { name: "m5 mantra", description: "shredders", unit_price: 700, merchant_id: merchant.id }

    patch "/api/v1/items/#{item.id}", params: { item: item_params }

    expect(response).to be_successful
    updated_item = Item.find(item.id)
    expect(updated_item.name).to eq("m5 mantra")
  end

  it "An Item can be deleted" do
    merchant = create(:merchant)
    create_list(:item, 2, merchant: merchant)
    item = create(:item, merchant: merchant)
    expect(Item.all.count).to eq(6)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.all.count).to eq(5)
    expect{ Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
