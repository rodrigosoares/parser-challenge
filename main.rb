require 'nokogiri'
require_relative 'lib/batch'
require_relative 'lib/product'

file_path = ARGV.first

raise 'Missing file path' unless file_path

xml = File.open(file_path) { |file| Nokogiri::XML(file) }
items = xml.xpath('//item')
batch = Batch.new

items.each do |item|
  id = item.at_xpath('g:id')&.text
  title = item.at_xpath('title')&.text
  description = item.at_xpath('description')&.text

  product = Product.new(id, title, description)
  batch.flush() if batch.large?(product.bytesize)
  batch.add(product)
end

batch.flush()
