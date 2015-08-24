class Entity
	@stats = {
		"is_mortal" => false, #can I die?
		"hit_points" => 0, #hp 1-9999
		"entity_type" => "none", #["object",weapon,enemy,player]
		"size" => "none", #[tiny,small,medium,large,huge]
		"elemental_type" => "none", #[fire,Water,earth,air,spirit,acid,none]
		"damage" => 0, #damage value on touch
		"sprite" => "none", #[dagger,sword,bow,wand,rock,player,zombie]
		"projectile" => "none" #[arrow,meteor,bolt,beam]
	}

	def initialize(stats = {})
		@stats = {
			"is_mortal" => stats["is_mortal"],
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
					newstat = mutate_stat(stat, key)
					bebe_stats[key] = newstat
				else
					bebe_stats[key] = stat
				end
			else
				if rand < 0.1
					newstat = mutate_stat(mate_stats[key], key)
					bebe_stats[key] = newstat
				else	
					bebe_stats[key] = mate_stats[key]
				end
			end
		end
		return Entity.new(bebe_stats)
	end

	def mutate_stat(stat, key)
		if stat.is_a? Integer or stat.is_a? Float
			if rand > 0.5
				return stat = stat + stat*0.5
			else
				return stat = stat - stat*0.5
			end
		else
			return "mutated #{stat}"
		end
	end

	def randomize_stats()
		all_types = ["object","weapon","enemy"]
		all_sizes = ["tiny","small","medium","large","huge"]
		all_elemental = ["fire","water","earth","air","spirit","acid","lightning","vampiric","holy","shadow","knockback","none"]
		all_sprites = ["dagger","sword","bow","wand","rock","zombie","wolf","bat","slime","bush","treasure_chest"]
		all_projectiles = ["arrow","meteor","bolt","beam","spray","bomb","sparkles", "none"]

		stats = {}
		stats["is_mortal"] = rand < 0.5 ? true : false
		stats["hit_points"] = (rand * 1024).floor
		stats["damage"] = (rand * 512).floor
		stats["entity_type"] = all_types[rand(0...all_types.length)]
		stats["size"] = all_sizes[rand(0...all_sizes.length)]
		stats["elemental_type"] = all_elemental[rand(0...all_elemental.length)]
		stats["sprite"] = all_sprites[rand(0...all_sprites.length)]
		stats["projectile"] = all_projectiles[rand(0...all_projectiles.length)]

		return stats
	end 
end

#start with ranom gene pool
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