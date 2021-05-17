require 'json'

class Product
  def initialize(id, title, description)
    @id = id
    @title = title
    @description = description
  end

  def to_obj
    { id: @id, title: @title, description: @description }
  end

  def to_json
    to_obj.to_json
  end

  def bytesize
    to_json.bytesize
  end
end
