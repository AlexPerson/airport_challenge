describe "User Stories" do
	let(:airport) { Airport.new(weather_report, 20) }
	let(:plane) { Plane.new }
	let(:weather_report) { WeatherReport.new }
	
	context 'when not stormy' do
		before do
			allow(weather_report).to receive(:stormy?).and_return false
		end
		# As an air traffic controller
		# So planes can land safely at my airport
		# I would like to instruct a plane to land 
		it 'so planes can land at airports, instruct a plane to land' do
			expect { airport.land(plane) }.not_to raise_error
		end

		# As an air traffic controller
		# So planes can take off safely from my airport
		# I would like to instruct a plane to take off
		it 'so planes take off from airports, instruct a plane to take off' do
			airport.land(plane)
			airport.take_off(plane)
			expect { airport.take_off(plane) }.not_to raise_error
		end

		# As an air traffic controller
		# So that I can ensure safe take off procedures
		# I want planes only to take off from the airport they are at
		it 'takes off planes only from the airport they are at' do
			airport_2 = Airport.new(weather_report, 20)
			airport_2.land(plane)
			expect { airport.take_off(plane) }.to raise_error 'Cannot take off plane: plane is not at this airport'

		end

		# As an air traffic controller
		# So that I can avoid collisions
		# I want to prevent airplanes landing when my airport is full
		context 'when airport is full' do
			it 'does not allow planes to land' do
				20.times do
					airport.land(plane)
				end
				expect { airport.land(plane) }.to raise_error 'Cannot land plane: airport full'
			end
		end

		# As the system designer
		# So that the software can be used for many different airports
		# I would like a default airport capacity that can be overridden as appropriate
		it 'airports have a default capacity' do
			default_airport = Airport.new(weather_report)
			Airport::DEFAULT_CAPACITY.times { default_airport.land(plane) }
			expect { default_airport.land(plane) }.to raise_error 'Cannot land plane: airport full'
		end
	end

	# As an air traffic controller
	# So that I can avoid accidents
	# I want to prevent airplanes landing or taking off when the weather is stormy
	context 'when weather is stormy' do
		before do
			allow(weather_report).to receive(:stormy?).and_return true
		end

		it 'does not allow planes to land' do
			expect { airport.land(plane) }.to raise_error 'Cannot land plane: weather is stormy'
		end

		it 'does not allow planes to take off' do
			expect { airport.take_off(plane) }.to raise_error 'Plane cannot take off: weather is stormy'
		end
	end
end
