class Entity
	@stats = {
		"is_mortal" => false, #can I die?
		"hit_points" => 0, #hp 1-9999
		"entity_type" => "none", #["object",weapon,enemy,player]
		"size" => "none", #[tiny,small,medium,large,huge]
		"collides_with" => "none", #["object",weapon,enemy,player]
		"damages_on_collide" => "none", #["object",weapon,enemy,player]
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
			"collides_with" => stats["collides_with"],
			"damages_on_collide" => stats["damages_on_collide"],
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
				bebe_stats[key] = stat
			else
				bebe_stats[key] = mate_stats[key]
			end
		end

		return Entity.new(bebe_stats)
	end
end


@gene_pool = [
	Entity.new({
		"is_mortal" => true,
		"hit_points" => 5,
		"entity_type" => "object",
		"size" => "small",
		"collides_with" => ['enemy','player'],
		"damages_on_collide" => "none",
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
		"collides_with" => ['enemy','player','weapon'],
		"damages_on_collide" => "none",
		"elemental_type" => "earth",
		"damage" => 0,
		"sprite" => 'rock',
		"projectile" => "none"
	}),
	Entity.new({
		"is_mortal" => false,
		"hit_points" => 0,
		"entity_type" => "weapon",
		"size" => "tiny",
		"collides_with" => ["object","weapon","enemy"],
		"damages_on_collide" => ["object","enemy"],
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
		"collides_with" => ["object","weapon","enemy"],
		"damages_on_collide" => ["object","enemy"],
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
		"collides_with" => ["object","weapon","enemy"],
		"damages_on_collide" => ["object","enemy"],
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
		"collides_with" => ["object","weapon","enemy"],
		"damages_on_collide" => ["object","enemy"],
		"elemental_type" => "air",
		"damage" => 0,
		"sprite" => "wand",
		"projectile" => "meteor"
	}),
	Entity.new({
		"is_mortal" => true,
		"hit_points" => 5,
		"entity_type" => "enemy",
		"size" => "large",
		"collides_with" => ["object","weapon","player"],
		"damages_on_collide" => ["object","player"],
		"elemental_type" => "acid",
		"damage" => 10,
		"sprite" => "zombie",
		"projectile" => "none"
	}),
]

@gen_1 = []
@gene_pool.each_with_index {|val, index| 
	@gen_1 << val.breed(@gene_pool[rand(0...@gene_pool.length)])
}

puts ""
@gen_1.each_with_index {|val, index| 
	val.get_stats().each do |key, value|
		puts "#{key} --> #{value}"
	end
	puts ""
}
puts ""