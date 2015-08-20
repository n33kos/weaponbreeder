class Weapon
	@stats = {
		"weapon_damage" => 0,
		"damage_type" => "none",
		"weapon_appearance" => "none",
		"weapon_size" => "none"
	}

	def initialize(stats)
		@stats = {
			"weapon_damage" => stats["weapon_damage"],
			"damage_type" => stats["damage_type"],
			"weapon_appearance" => stats["weapon_appearance"],
			"weapon_size" => stats["weapon_size"]
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

		return Weapon.new(bebe_stats)
	end
end


#------------------------Generation 1-----------------
mom = Weapon.new({
	"weapon_damage" => 12,
	"damage_type" => "ice",
	"weapon_appearance" => "sword",
	"weapon_size" => "large"
})
dad = Weapon.new({
	"weapon_damage" => 18,
	"damage_type" => "piercing",
	"weapon_appearance" => "bow",
	"weapon_size" => "medium"
})

g1 = mom.breed(dad)
g12 = mom.breed(dad)
g13 = mom.breed(dad)
g14 = mom.breed(dad)

puts ""
puts g1.get_stats()
puts g12.get_stats()
puts g13.get_stats()
puts g14.get_stats()
puts ""

#------------------------Generation 2-----------------
newguy = Weapon.new({
	"weapon_damage" => 20,
	"damage_type" => "acid",
	"weapon_appearance" => "mace",
	"weapon_size" => "small"
})

g2 = g1.breed(newguy)
g22 = g12.breed(newguy)
g23 = g13.breed(newguy)
g24 = g14.breed(newguy)

puts ""
puts g2.get_stats()
puts g22.get_stats()
puts g23.get_stats()
puts g24.get_stats()
puts ""
 
#------------------------Generation 3-----------------
newguy2 = Weapon.new({
	"weapon_damage" => 15,
	"damage_type" => "fire",
	"weapon_appearance" => "staff",
	"weapon_size" => "huge"
})

g3 = g2.breed(newguy2)
g32 = g22.breed(newguy2)
g33 = g23.breed(newguy2)
g34 = g24.breed(newguy2)

puts ""
puts g3.get_stats()
puts g32.get_stats()
puts g33.get_stats()
puts g34.get_stats()
puts ""
 