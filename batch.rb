require_relative 'external_service'

class Batch
  ONE_MEGA_BYTE = 1_048_576.0
  MAX_BYTE_SIZE = ONE_MEGA_BYTE * 5

  def initialize(items = [])
    @items = items.map(&:to_obj)
    @byte_count = items.to_json.bytesize
    @service = ExternalService.new
  end

  def add(item)
    new_item = item.to_obj
    @items << new_item
    @byte_count += new_item.to_json.bytesize
  end

  def flush
    @service.call(@items.to_json)
    reset
  end

  def large?(other_size)
    @byte_count + other_size > MAX_BYTE_SIZE
  end

  private

  def reset
    @items = []
    @byte_count = 0
  end
end
