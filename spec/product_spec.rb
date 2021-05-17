RSpec.describe Product do
  let(:id) { '123' }
  let(:title) { 'Foo' }
  let(:description) { 'Foo bar baz qux' }

  before(:each) do
    @product = Product.new(id, title, description)
  end

  context '.new' do
    it 'instantiates a product' do
      expect(@product).to be_an_instance_of(Product)
    end
  end

  context '#to_obj' do
    it 'returns an object version of the product' do
      expect(@product.to_obj).to eq({ id: id, title: title, description: description })
    end
  end

  context '#to_json' do
    it 'returns a JSON version of the product' do
      expect(@product.to_json).to eq(
        "{\"id\":\"#{id}\",\"title\":\"#{title}\",\"description\":\"#{description}\"}"
      )
    end
  end

  context '#bytesize' do
    it 'returns the JSON size in bytes' do
      expect(@product.bytesize).to be(58)
    end
  end
end
