class Invoice < ApplicationRecord
  validates :status, presence: true
  enum status: %w[shipped]

  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
end
