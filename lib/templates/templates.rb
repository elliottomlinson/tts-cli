require 'mustache'

module Templates
	class Base < Mustache
		attr_accessor :object_states
	end

	Base.template_file = "lib/templates/base.mustache"

	class Config < Mustache
		attr_accessor :sessionName
	end

	Config.template_file = "lib/templates/config.mustache"
end