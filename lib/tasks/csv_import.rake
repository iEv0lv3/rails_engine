require 'csv'

namespace :csv do
  desc 'Import from csv files'

  task import: [:environment] do
    customers = 'lib/csv_data/customers.csv'
    merchants = 'lib/csv_data/merchants.csv'
    invoices = 'lib/csv_data/invoices.csv'
    items = 'lib/csv_data/items.csv'
    invoice_items = 'lib/csv_data/invoice_items.csv'
    transactions = 'lib/csv_data/transactions.csv'

    system 'rails db:reset'

    CSV.foreach(customers, headers: true, header_converters: :symbol) do |row|
      customer_hash = row.to_hash
      Customer.create!(customer_hash)
    end

    puts '>> Loaded customers.csv <<'

    CSV.foreach(merchants, headers: true, header_converters: :symbol) do |row|
      merchant_hash = row.to_hash
      Merchant.create!(merchant_hash)
    end

    puts '>> Loaded merchants.csv <<'

    CSV.foreach(invoices, headers: true, header_converters: :symbol) do |row|
      invoice_hash = row.to_hash
      Invoice.create!(invoice_hash)
    end

    puts '>> Loaded invoices.csv <<'

    CSV.foreach(items, headers: true, header_converters: :symbol) do |row|
      item_hash = row.to_hash
      Item.create!(item_hash)
    end

    puts '>> Loaded items.csv <<'

    CSV.foreach(invoice_items, headers: true, header_converters: :symbol) do |row|
      invoice_items_hash = row.to_hash
      InvoiceItem.create!(invoice_items_hash)
    end

    puts '>> Loaded invoice_items.csv <<'

    CSV.foreach(transactions, headers: true, header_converters: :symbol) do |row|
      transaction_hash = row.to_hash
      Transaction.create!(transaction_hash)
    end

    puts '>> Loaded transactions.csv <<'

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
