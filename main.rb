require_relative 'lib/batch'
require_relative 'lib/parser'
require_relative 'lib/product'
require_relative 'lib/external_service'

file_path = ARGV.first

raise 'Missing file path' unless file_path

parser = Parser.new(file_path)
batch = Batch.new(ExternalService.new)

parser.iterate do |id, title, description|
  product = Product.new(id, title, description)
  batch.flush if batch.large?(product.bytesize)
  batch.add(product)
end

batch.flush
