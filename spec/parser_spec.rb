RSpec.describe Parser do
  before(:each) do
    @parser = Parser.new('spec/fixtures/test.xml')
  end

  context '.new' do
    it 'initializes the parser loading an XML file' do
      expect(@parser).to be_an_instance_of(Parser)
    end
  end

  context '#iterate' do
    it 'iterates the array of items and yields the supplied block over them' do
      items = []

      @parser.iterate do |id, title, description|
        items << { id: id, title: title, description: description }
      end

      expect(items).to include({
        id: '1',
        title: 'Foo',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      })
    end
  end
end
