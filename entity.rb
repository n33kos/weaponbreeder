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
				if rand < 0.1
					bebe_stats[key] = mutate_stat(stat, key)
				else
					bebe_stats[key] = stat
				end
			else
				if rand < 0.1
					bebe_stats[key] = mutate_stat(mate_stats[key], key)
				else	
					bebe_stats[key] = mate_stats[key]
				end
			end
		end
		return Entity.new(bebe_stats)
	end

	def mutate_stat(stat, key)
		if key == "entity_type"
			return $all_types[rand(0...$all_types.length)]
		elsif key == "is_mortal"
			return rand < 0.5 ? true : false
		elsif key == "size"
			return $all_sizes[rand(0...$all_sizes.length)]
		elsif key == "elemental_type"
			return $all_elemental[rand(0...$all_elemental.length)]
		elsif key == "sprite"
			return $all_sprites[rand(0...$all_sprites.length)]
		elsif key == "projectile"
			return $all_projectiles[rand(0...$all_projectiles.length)]
		elsif stat.is_a? Integer or stat.is_a? Float
			if rand > 0.5
				return (stat + stat*0.5).to_i
			else
				return (stat - stat*0.5).to_i
			end
		end
	end

	def randomize_stats()
		stats = {}
		stats["is_mortal"] = rand < 0.5 ? true : false
		stats["level"] = (rand * 50).floor
		stats["hit_points"] = (rand * 100).floor
		stats["damage"] = (rand * 100).floor
		stats["entity_type"] = $all_types[rand(0...$all_types.length)]
		stats["size"] = $all_sizes[rand(0...$all_sizes.length)]
		stats["elemental_type"] = $all_elemental[rand(0...$all_elemental.length)]
		stats["sprite"] = $all_sprites[rand(0...$all_sprites.length)]
		stats["projectile"] = $all_projectiles[rand(0...$all_projectiles.length)]
		return stats
	end 
end