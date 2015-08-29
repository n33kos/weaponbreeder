# WeaponBreeder 1.0
# ------------------------------------------------
# usage: Ruby WeaponBreeder.rb {int:generations} {int:babies per generation} {int:generation_delay}
# Customization: Add new type objects to the $probability_cloud array and give them whatever stats you want.
# ------------------------------------------------


#load libs
load 'type.rb'
load 'entity.rb'

#default Values
$generation_to_iterate = 10;
$babies_per_generation = 64
$generation_delay = 0.01;

puts ARGV.inspect


#get arguments
if ARGV[0]
	$generation_to_iterate = ARGV[0];
end
if ARGV[1]
	$babies_per_generation = ARGV[1];
end
if ARGV[2]
	$generation_delay = ARGV[2];
end

def generate_probability_cloud(entity_types)
	probability_cloud = {:type => []}
	entity_types.each do |obj_key, obj_vars|
		probability_cloud[:type] << obj_key.name
		probability_cloud = probability_cloud.merge(obj_key.variables){ |key, original, new| original + new }
	end	
	return probability_cloud
end

def randomize_stats()
	stats = {}
	$probability_cloud.each do |symbol,possible_stats|
		possible_stats.each do |val|
			if (val.is_a? Integer or val.is_a? Float) and possible_stats.length == 2
				#if its 2 integers or floats its probably a range
				stats[symbol] = rand(possible_stats[0]...possible_stats[1])
				break
			else
				#otherwise its probably a random
				stats[symbol] = possible_stats[rand(0...possible_stats.length)]
				break
			end
		end
	end
	return stats
end

def mutate_stats(stats)
	mutated_stats = {}
	stats.each do |key, val|
		if val.is_a? Integer or val.is_a? Float
			if rand > 0.5

				#fitness
				rand_array = []
				8.times {rand_array << rand}
				rand_array.sort! { |x,y| y <=> x }

				mutated_stats[key] = (stats[key] + 100*rand_array[0]).to_i
			else
				#fitness
				rand_array = []
				8.times {rand_array << rand}
				rand_array.sort!

				mutated_stats[key] = (stats[key] - 100*rand_array[0]).to_i
			end
		else
			mutated_stats[key] = $probability_cloud[key][rand(0...$probability_cloud[key].length)]
		end
	end
	return mutated_stats
end

#init entity types here
$probability_cloud = generate_probability_cloud([
	Type.new("object", {
		:size => ["medium","large","huge"],
		:element => ["fire","water","earth","air","spirit","acid","lightning","vampiric","holy","shadow","knockback","none"],
		:sprite => ["rock","bush","treasure_chest","flowers"]
	}),
	Type.new("weapon", {
		:size => ["tiny","small"],
		:projectile => ["arrow","meteor","bolt","light_beam","bomb","sparkles","bubbles","none"],
		:damage => [0,10],#[minval,maxval]
		:sprite => ["dagger","sword","bow","wand"]
	}),
	Type.new("enemy", {
		:is_mortal => [true,false],
		:level => [0,10],#[minval,maxval]
		:hit_point => [0,10],#[minval,maxval]
		:sprite => ["zombie","wolf","bat","slime","troll"],
		:behavior => ["wander","seek","oscillate"]
	}),
	Type.new("armor", {
		:level => [0,10],#[minval,maxval]
		:defense => [0,10],#[minval,maxval]
		:projectile_resistance => [0,10],
		:melee_resistance => [0,10],
		:sprite => ["helm","gauntlet","pauldron","buckler"]
	})
]);


#start with random gene pool
@gene_pool = []
$babies_per_generation.to_i.times do
	rand_entity = Entity.new()
	rand_entity.set_stats(randomize_stats())
	@gene_pool << rand_entity
end


@generation_count = 1
$generation_to_iterate.to_i.times do
	puts "-----------------------Generation #{@generation_count}--------------------------------"
	puts "---------------------------------------------------------------------------------------"
	@children_pool = []
	@bebe_count = 1
	@gene_pool.each do |key, val|
		if rand < 0.005
			key.set_stats(mutate_stats(key.get_stats))
		end
		bebe = key.breed(@gene_pool[rand(0...@gene_pool.length)])
		@children_pool << bebe
		
		puts "Child #{@bebe_count}"
		bebe.get_stats.each do |symbol, value|
			print "#{symbol}:#{value}  "
		end
		puts ""
		@bebe_count = @bebe_count+1
	end
	@gene_pool = @children_pool
	@generation_count = @generation_count + 1
	sleep Float($generation_delay)
end