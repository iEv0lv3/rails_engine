class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0, less_than: 100000 }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_by_name(search)
    @items = where(
      Item.arel_table[:name]
      .lower
      .matches("%#{search.downcase}%")
    )
  end

  def self.find_by_description(search)
    @items = where(
      Item.arel_table[:description]
      .lower
      .matches("%#{search.downcase}%")
    )
  end

  def self.find_by_unit_price(search)
    @items = where(unit_price: search)
  end

  def self.find_by_created(created_at)
    @items = where(
      Item.arel_table[:created_at]
      .to_s
      .match(created_at)
    )
  end

  def self.find_by_updated(updated_at)
    @items = where(
      Item.arel_table[:updated_at]
      .to_s
      .match(updated_at)
    )
  end
end
