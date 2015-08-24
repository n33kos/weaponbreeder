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

	def initialize(stats)
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
				return stat*2
			else
				return stat/2
			end
		else
			return "mutated #{stat}"
		end
	end
end


@gene_pool = [
	Entity.new({
		"is_mortal" => true,
		"hit_points" => 5,
		"entity_type" => "object",
		"size" => "small",
		"elemental_type" => "fire",
		"damage" => 2,
		"sprite" => 'flame',
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => true,
		"hit_points" => 5,
		"entity_type" => "object",
		"size" => "medium",
		"elemental_type" => "earth",
		"damage" => 0,
		"sprite" => 'rock',
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 50,
		"entity_type" => "object",
		"size" => "large",
		"elemental_type" => "none",
		"damage" => 0,
		"sprite" => 'treasure_chest',
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 0,
		"entity_type" => "weapon",
		"size" => "large",
		"elemental_type" => "holy",
		"damage" => -2,
		"sprite" => 'dagger',
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 0,
		"entity_type" => "weapon",
		"size" => "small",
		"elemental_type" => "shadow",
		"damage" => 12,
		"sprite" => 'wand',
		"projectile" => "magic_missile"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 0,
		"entity_type" => "weapon",
		"size" => "tiny",
		"elemental_type" => "water",
		"damage" => 3,
		"sprite" => "dagger",
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 0,
		"entity_type" => "weapon",
		"size" => "medium",
		"elemental_type" => "fire",
		"damage" => 5,
		"sprite" => "sword",
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 0,
		"entity_type" => "weapon",
		"size" => "large",
		"elemental_type" => "earth",
		"damage" => 0,
		"sprite" => "bow",
		"projectile" => "arrow"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 0,
		"entity_type" => "weapon",
		"size" => "huge",
		"elemental_type" => "air",
		"damage" => 0,
		"sprite" => "wand",
		"projectile" => "meteor"
	}),
	Entity.new({
		"is_mortal" => true,
		"hit_points" => 10,
		"entity_type" => "enemy",
		"size" => "large",
		"elemental_type" => "acid",
		"damage" => 10,
		"sprite" => "zombie",
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => true,
		"hit_points" => 5,
		"entity_type" => "enemy",
		"size" => "small",
		"elemental_type" => "vampiric",
		"damage" => 2,
		"sprite" => "vampire_bat",
		"projectile" => "fangs"
	}),
	Entity.new({
		"is_mortal" => true,
		"hit_points" => 8,
		"entity_type" => "enemy",
		"size" => "medium",
		"elemental_type" => "lightning",
		"damage" => 6,
		"sprite" => "wolf",
		"projectile" => "none"
	}),
]

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