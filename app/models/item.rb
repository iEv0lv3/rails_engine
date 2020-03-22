class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0, less_than: 100000 }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
