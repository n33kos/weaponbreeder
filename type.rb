class Type
	@type_name = "none"
	@type_variables

	#type_name - String
	#type_variables - {string => [string,string,string], string => [string,string,string]}
	def initialize(type_name, type_variables)
		@type_name = type_name
		@type_variables = type_variables
	end

	def name
		return @type_name
	end

	def variables
		return @type_variables
	end

end