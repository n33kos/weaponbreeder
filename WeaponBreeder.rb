# WeaponBreeder 1.1
# ------------------------------------------------
# usage: ruby weaponbreeder.rb {int:generations} {int:child_count} {int:generation_delay} {int:fitness_iterations} {bool:display_intermediate_generations}
# Customization: Add new type objects to the $probability_cloud array and give them whatever stats you want.
# ------------------------------------------------

#------Libs------
require 'yaml'

#------Classes------
load './classes/type.rb'
load './classes/entity.rb'

#------Default Configs------
$generation_to_iterate = 20
$child_count = 5
$generation_delay = 0.01
$fitness_iterations = 10
$display_intermediate_generations = false

#------Global Variables------
$types = []
$probability_cloud
$gene_pool
$children_pool = []

#------Arguments------
if ARGV[0]
	$generation_to_iterate = ARGV[0].to_i
end

if ARGV[1]
	$child_count = ARGV[1].to_i
end

if ARGV[2]
	$generation_delay = ARGV[2].to_i
end

if ARGV[3]
	$fitness_iterations = ARGV[3].to_i
end

if ARGV[4]
	$display_intermediate_generations = ARGV[4]
end

#------Functions------
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
				$fitness_iterations.times {rand_array << rand}
				rand_array.sort! { |x,y| y <=> x }

				mutated_stats[key] = (stats[key] + 100*rand_array[0]).to_i
			else
				#fitness
				rand_array = []
				$fitness_iterations.times {rand_array << rand}
				rand_array.sort!

				mutated_stats[key] = (stats[key] - 100*rand_array[0]).to_i
			end
		else
			mutated_stats[key] = $probability_cloud[key][rand(0...$probability_cloud[key].length)]
		end
	end

	return mutated_stats
end

def import_types()
	Dir["./types/*.yml"].each {|file|
		type_name = File.basename(file, ".*")
		config = YAML.load_file(file)
		$types.push(Type.new(type_name, config))
	}
end

def print_generation(generation_count)
	puts "-----------------------Generation #{generation_count}---------------------------"

	$children_pool.each_with_index do |item, i|
		puts "Child #{i + 1}"

		item.get_stats.each do |symbol, value|
			print "#{symbol}: #{value} \n"
		end
		puts ""
	end
end

def seed_gene_pool()
	gene_pool = []
	$child_count.to_i.times do
		rand_entity = Entity.new()
		rand_entity.set_stats(randomize_stats())
		gene_pool << rand_entity
	end

	return gene_pool
end

#------Execution------
import_types()
$probability_cloud = generate_probability_cloud($types)

# start with random gene pool
$gene_pool = seed_gene_pool()

generation_count = 1
$generation_to_iterate.to_i.times do
	$children_pool = []
	bebe_count = 1
	$gene_pool.each do |key, val|
		if rand < 0.005
			key.set_stats(mutate_stats(key.get_stats))
		end
		bebe = key.breed($gene_pool[rand(0...$gene_pool.length)])
		$children_pool << bebe
		bebe_count = bebe_count + 1
	end
	$gene_pool = $children_pool
	generation_count = generation_count + 1

	if generation_count == $generation_to_iterate
		print_generation(generation_count)
	else
		if $display_intermediate_generations
			print_generation(generation_count)
		end
	end


	sleep Float($generation_delay)
end
