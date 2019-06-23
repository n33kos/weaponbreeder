class Entity
	@stats = {}

	def initialize(stats = {})
		@stats = stats
	end

	def get_stats()
		return @stats
	end

	def set_stats(stats)
		@stats = stats
	end

	def breed(mate)
		mate_stats = mate.get_stats
		bebe_stats = {}
		@stats.each do |key, stat|
			if rand > 0.5
				bebe_stats[key] = stat
			else
				bebe_stats[key] = mate_stats[key]
			end
		end
		return Entity.new(bebe_stats)
	end
end
