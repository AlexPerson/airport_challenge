require 'airport.rb'

describe Airport do
	subject(:airport) { described_class.new }

	it 'instructs plane to land' do
		expect(airport).to respond_to(:land).with(1).argument
	end
end