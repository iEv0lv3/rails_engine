require 'csv'

namespace :api::v1

desc 'Import from csv files'
task import: [:environment] do
  file = 'db/product.csv'
  CSV.foreach(file, headers: true) do |row|
    product_hash = row.to_hash
    product = Product.where(id: product_hash['id'])
    if product.count == 1
      product.first.update_attributes(product_hash)
    else
      Product.create!(product_hash)
    end
  end
end
