#1. Determine best way to make lists dynamically created based on type variables
#2. Implement a level based value scaling system
#3. Implement 'fitness' in breeding algorithm
#3. Determine where this will be deployed (Executable, Rails, Terminal)
#4. Build an easy-to-use GUI

#load libs
load 'type.rb'
load 'entity.rb'

#init entity types
$all_types = [
	Type.new("object", {
		"sizes" => ["tiny","small","medium","large","huge"],
		"elements" => ["fire","water","earth","air","spirit","acid","lightning","vampiric","holy","shadow","knockback","none"],
		"sprites" => ["dagger","sword","bow","wand","rock","zombie","wolf","bat","slime","bush","treasure_chest","troll","flowers"]
	}),
	Type.new("weapon", {
		"projectiles" => ["arrow","meteor","bolt","light_beam","bomb","sparkles","bubbles","none"]
	}),
	Type.new("enemy", {
		"is_mortal" => [true,false],
		"level" => [0,60],#[minval,maxval]
		"hit_points" => [0,100],#[minval,maxval]
	})
]


#PUT THESE GUYS UP IN THE TYPE DECLARATIONS	
#"entity_type" => stats["entity_type"],
#"size" => stats["size"],
#"elemental_type" => stats["elemental_type"],
#"damage" => stats["damage"],
#"sprite" => stats["sprite"],
#"projectile" => stats["projectile"]

#THEN REGENERATE ALL THE TYPE LISTS

#THEN MODIFY THE ENTITY TO DYNAMICALLY GRAB ALL OF THE @ALL_SOMETHING LISTS


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
	if key == "entity_type"
		puts value.name
	else
		puts "#{key} - #{value}"
	end
end
puts ""