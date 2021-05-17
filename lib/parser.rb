require 'nokogiri'

class Parser
  def initialize(file_path)
    @xml = File.open(file_path) { |file| Nokogiri::XML(file) }
  end

  def iterate
    items = @xml.xpath('//item')
    items.each do |item|
      id = item.at_xpath('g:id')&.text
      title = item.at_xpath('title')&.text
      description = item.at_xpath('description')&.text
      yield id, title, description if block_given?
    end
  end
end
