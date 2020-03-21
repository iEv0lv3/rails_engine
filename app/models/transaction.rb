class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true
  enum result: %w[success]

  belongs_to :invoice
end
