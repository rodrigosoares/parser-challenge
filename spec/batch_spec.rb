RSpec.describe Batch do
  let(:product) { Product.new('123', 'Foo', 'Foo bar baz qux') }
  let(:service) { spy('external_service') }

  before(:each) do
    allow(service).to receive(:call)
    @batch = Batch.new(service)
  end

  context '.new' do
    it 'instantiates a batch' do
      expect(@batch).to be_an_instance_of(Batch)
    end
  end

  context '#add' do
    it 'adds an item to the batch' do
      @batch.add(product)
      expect(@batch.instance_variable_get(:@items)).to include(product.to_obj)
      expect(@batch.instance_variable_get(:@byte_count)).to be(60)
    end
  end

  context '#flush' do
    it 'sends current items to the external service and clears the batch' do
      @batch.add(product)
      old_items = @batch.instance_variable_get(:@items)

      @batch.flush
      current_items = @batch.instance_variable_get(:@items)
      bytes = @batch.instance_variable_get(:@byte_count)

      expect(service).to have_received(:call).with(old_items.to_json)
      expect(current_items).to be_empty
      expect(bytes).to be(2)
    end
  end

  context '#large?' do
    it 'returns false if the batch is smaller than the limit' do
      expect(@batch.large?(1_048_576.0 * 4)).to be(false)
    end

    it 'returns true if the batch is larger than the limit' do
      expect(@batch.large?(1_048_576.0 * 6)).to be(true)
    end
  end
end
