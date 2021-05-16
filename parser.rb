require 'json'
require 'nokogiri'
require_relative 'external_service'

ONE_MEGA_BYTE = 1_048_576.0
MAX_SIZE = ONE_MEGA_BYTE * 5

file_path = ARGV.first

raise 'Missing file path' unless file_path

xml = File.open(file_path) { |file| Nokogiri::XML(file) }
items = xml.xpath('//item')
batch = []
byte_count = 0
service = ExternalService.new

items.each do |item|
  id = item.at_xpath('g:id')&.text
  title = item.at_xpath('title')&.text
  description = item.at_xpath('description')&.text

  obj = { id: id, title: title, description: description }
  obj_size = obj.to_json.bytesize

  if byte_count + obj_size < MAX_SIZE
    byte_count += obj_size
    batch << obj
  else
    service.call(batch.to_json)
    batch = [obj]
    byte_count = obj_size
  end
end

service.call(batch.to_json)
