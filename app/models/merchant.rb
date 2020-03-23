class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices

  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_by_name(search)
    @merchants = where(
      Merchant.arel_table[:name]
      .lower
      .matches("%#{search.downcase}%")
    )
  end

  def self.find_by_created(created_at)
    @merchants = where(
      Merchant.arel_table[:created_at]
      .to_s
      .match(created_at)
    )
  end

  def self.find_by_updated(updated_at)
    @merchants = where(
      Merchant.arel_table[:updated_at]
      .to_s
      .match(updated_at)
    )
  end

  def revenue
    transactions
      .where(result: 'success')
      .joins(:invoice_items)
      .sum('invoice_items.quantity * invoice_items.unit_price').round(2)
  end

  def revenue_by_date(start_date, end_date)
    transactions
      .where(result: 'success')
      .joins(:invoice_items)
      .where(created_at: start_date..end_date)
      .sum('invoice_items.quantity * invoice_items.unit_price').round(2)
  end

  def self.most_revenue(quantity)
    all.sort_by do |merchant|
      merchant.revenue
    end.reverse[0..quantity.to_i - 1]
  end
end
