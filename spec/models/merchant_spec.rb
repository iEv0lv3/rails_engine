require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'class methods' do
    it 'find_by_name' do
      merchant1 = create(:merchant, name: "Swag Shop")
      merchant2 = create(:merchant, name: "The Swimmer's Friend")
      merchant3 = create(:merchant, name: "Dota2 Shop")

      expect(Merchant.find_by_name("sw")).to eq([merchant1, merchant2])
    end

    it 'find_by_created' do
      merchant = create(:merchant, name: "Dota2 Shop")

      expect(Merchant.find_by_created(merchant.created_at.to_s)).to eq([merchant])
    end

    it 'find_by_updated' do
      merchant = create(:merchant, name: "Dota2 Shop")

      expect(Merchant.find_by_updated(merchant.updated_at.to_s)).to eq([merchant])
    end
  end
end
