require 'weather_report.rb'

class Airport

	def initialize(capacity, weather_report)
		@capacity = capacity
		@planes = []
		@weather_report = weather_report
	end

	def land(plane)
		raise 'Cannot land plane: airport full' if full?
		raise 'Cannot land plane: weather is stormy' if stormy?
		@planes << plane
	end

	def take_off(plane)
		raise 'Plane cannot take off: weather is stormy' if stormy?
		raise 'Cannot take off plane: plane is not at this airport' unless at_airport?(plane)
	end

	private

	def full?
		@planes.length >= @capacity
	end

	def stormy?
		@weather_report.stormy?
	end

	def at_airport?(plane)
		@planes.include?(plane)
	end

end