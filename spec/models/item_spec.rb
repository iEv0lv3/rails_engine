require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'class methods' do
    it 'find_by_name' do
      merchant = create(:merchant, name: "Dota2 Shop")
      item1 = create(:item, name: "Blink Dagger", merchant: merchant)
      item2 = create(:item, name: "Eul's Sceptre", merchant: merchant)
      item3 = create(:item, name: "Atos Sceptre", merchant: merchant)

      expect(Item.find_by_name("scep")).to eq([item2, item3])
    end

    it 'find_by_description' do
      merchant = create(:merchant, name: "Dota2 Shop")
      item1 = create(:item, name: "Blink Dagger", description: "Over here", merchant: merchant)
      item2 = create(:item, name: "Eul's Sceptre", description: "Up you go", merchant: merchant)
      item3 = create(:item, name: "Atos Sceptre", description: "Rooted you are", merchant: merchant)

      expect(Item.find_by_description("you")).to eq([item2, item3])
    end

    it 'find_by_unit_price' do
      merchant = create(:merchant, name: "Dota2 Shop")
      item1 = create(:item, name: "Blink Dagger", unit_price: 95.00, merchant: merchant)
      item2 = create(:item, name: "Eul's Sceptre", unit_price: 115.00, merchant: merchant)
      item3 = create(:item, name: "Atos Sceptre", unit_price: 105.00, merchant: merchant)

      expect(Item.find_by_unit_price(95.00)).to eq([item1])
    end

    it 'find_by_created' do
      merchant = create(:merchant, name: "Dota2 Shop")
      item1 = create(:item, name: "Blink Dagger", merchant: merchant)

      expect(Item.find_by_created(item1.created_at.to_s)).to eq([item1])
    end

    it 'find_by_updated' do
      merchant = create(:merchant, name: "Dota2 Shop")
      item1 = create(:item, name: "Blink Dagger", merchant: merchant)

      expect(Item.find_by_updated(item1.updated_at.to_s)).to eq([item1])
    end
  end
end
