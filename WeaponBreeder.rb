class Entity
	#1. Build a repeatable type class, then ensure that all stats for all types are included in the mix allowing for dynamically added types.
	#2. Implement a level based value scaling system
	#3. Determine where this will be deployed (Executable, Rails, Terminal)
	#4. Build an easy-to-use GUI

	@stats = {
		"is_mortal" => false,
		"level" => 1,
		"hit_points" => 0,
		"entity_type" => "none",
		"size" => "none",
		"elemental_type" => "none",
		"damage" => 0,
		"sprite" => "none",
		"projectile" => "none"
	}
	$all_types = ["object","weapon","enemy"]
	$all_sizes = ["tiny","small","medium","large","huge"]
	$all_elemental = ["fire","water","earth","air","spirit","acid","lightning","vampiric","holy","shadow","knockback","none"]
	$all_sprites = ["dagger","sword","bow","wand","rock","zombie","wolf","bat","slime","bush","treasure_chest","troll","flowers"]
	$all_projectiles = ["arrow","meteor","bolt","light_beam","bomb","sparkles","bubbles","none"]

	def initialize(stats = {})
		@stats = {
			"is_mortal" => stats["is_mortal"],
			"level" => stats["level"],
			"hit_points" => stats["hit_points"],
			"entity_type" => stats["entity_type"],
			"size" => stats["size"],
			"elemental_type" => stats["elemental_type"],
			"damage" => stats["damage"],
			"sprite" => stats["sprite"],
			"projectile" => stats["projectile"]
		}
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

#start with random gene pool
@gene_pool = []
20.times do
	rand_entity = Entity.new()
	rand_entity.set_stats(rand_entity.randomize_stats())
	@gene_pool << rand_entity
end


@gen_1 = []
@gene_pool.each_with_index do |val, index| 
	@gen_1 << val.breed(@gene_pool[rand(0...@gene_pool.length)])
end
puts "Generation 1"
puts "-----------------"
@gen_1[3].get_stats().each do |key, value|
	puts "#{key} - #{value}"
end
puts ""



@gen_2 = []
@gen_1.each_with_index  do |val, index| 
	@gen_2 << val.breed(@gen_1[rand(0...@gen_1.length)])
end
puts "Generation 2"
puts "-----------------"
@gen_1[3].get_stats().each do |key, value|
	puts "#{key} - #{value}"
end
puts ""



@gen_3 = []
@gen_2.each_with_index  do |val, index| 
	@gen_3 << val.breed(@gen_2[rand(0...@gen_2.length)])
end
puts "Generation 3"
puts "-----------------"
@gen_2[3].get_stats().each do |key, value|
	puts "#{key} - #{value}"
end
puts ""



@gen_4 = []
@gen_3.each_with_index  do |val, index| 
	@gen_4 << val.breed(@gen_3[rand(0...@gen_3.length)])
end
puts "Generation 4"
puts "-----------------"
@gen_3[3].get_stats().each do |key, value|
	puts "#{key} - #{value}"
end
puts ""