# WeaponBreeder 1.1
# ------------------------------------------------
# usage: ruby weaponbreeder.rb
# Customization: Add new type objects to the './types' folder to include them in child results
# ------------------------------------------------

#------Libs------
require 'yaml'

#------Classes------
load './classes/type.rb'
load './classes/entity.rb'

#------Default Configs------
$results = 5
$generations = 20
$mutation_chance = 0.05
$gene_pool_size = 20
$generation_delay = 0.01
$fitness_iterations = 8
$types_allowed = nil
$display_intermediate_generations = false

#------Functions------
def parseArguments()
	ARGV.each_with_index do |arg, index|
		case arg
			when '-r', '--results'
				# Integer
				$results = ARGV[index + 1].to_i
			when '-g', '--generations'
				# Integer
				$generations = ARGV[index + 1].to_i
			when '-m', '--mutation-chance'
				# Float
				$mutation_chance = ARGV[index + 1].to_f
			when '-p', '--gene-pool-size'
				# Integer
				$gene_pool_size = ARGV[index + 1].to_i
			when '-d', '--delay'
				# Integer
				$generation_delay = ARGV[index + 1].to_i
			when '-f', '--fitness-iterations'
				# Integer
				$fitness_iterations = ARGV[index + 1].to_i
			when '-t', '--types-allowed'
				# Comma separated list of types
				$types_allowed = ARGV[index + 1].gsub(/\s+/, "").split(',')
			when '-i', '--display-intermediate-generations'
				# Flag
				$display_intermediate_generations = true
		end
	end
end

def generate_probability_cloud(entity_types)
	probability_cloud = {:type => []}

	entity_types.each do |obj_key, obj_vars|
		probability_cloud[:type] << obj_key.name
		probability_cloud = probability_cloud.merge(obj_key.variables){ |key, original, new| original + new }
	end

	return probability_cloud
end

def randomize_stats(probability_cloud)
	stats = {}

	probability_cloud.each do |symbol,possible_stats|
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

def mutate_stats(stats, probability_cloud)
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
			mutated_stats[key] = probability_cloud[key][rand(0...probability_cloud[key].length)]
		end
	end

	return mutated_stats
end

def import_types()
	types = []

	Dir["./types/*.yml"].each do |file|
		type_name = File.basename(file, ".*")

		if $types_allowed.nil? or $types_allowed.include? type_name
			config = YAML.load_file(file)
			types.push(Type.new(type_name, config))
		end
	end

	return types
end

def print_generation(generation_count, children_pool)
	puts "-----------------------Generation #{generation_count + 1}---------------------------"

	children_pool.each_with_index do |child, i|
		print_result(child)
	end
end

def print_result(result)
	result.get_stats.each do |symbol, value|
		print "#{symbol}: #{value} \n"
	end
	puts ""
end

def seed_gene_pool(probability_cloud)
	gene_pool = []
	$gene_pool_size.times do
		rand_entity = Entity.new()
		rand_entity.set_stats(randomize_stats(probability_cloud))
		gene_pool << rand_entity
	end

	return gene_pool
end

def evolve_generations(probability_cloud, gene_pool)
	# Iterate through generations
	$generations.times do |index|
		# Clear children pool
		children_pool = []

		# Iterate through gene pool
		gene_pool.each do |key, val|
			# Make a bebe
			bebe = key.breed(gene_pool[rand(0...gene_pool.length)])

			# Random mutation chance
			if rand < $mutation_chance
				bebe.set_stats(mutate_stats(bebe.get_stats, probability_cloud))
			end

			# Add child to gene pool
			children_pool << bebe
		end

		# Set all newly created children as new gene pool
		gene_pool = children_pool

		# Display intermediate generations if desired
		if $display_intermediate_generations
			print_generation(index, children_pool)
		end

		# Delay for a bit
		sleep Float($generation_delay)
	end

	return gene_pool
end

def generate_results(gene_pool)
	results = []

	$results.times do |index|
		random_child = gene_pool[rand(0...gene_pool.length)]
		result = random_child.breed(gene_pool[rand(0...gene_pool.length)])
		results.push(result)
	end

	results.each do |result|
		print_result(result)
	end
end

#------Execution------
parseArguments()
types = import_types()
probability_cloud = generate_probability_cloud(types)
gene_pool = seed_gene_pool(probability_cloud)
gene_pool = evolve_generations(probability_cloud, gene_pool)
generate_results(gene_pool)
