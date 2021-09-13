require 'mustache'

module Templates
	class Base < Mustache
		attr_accessor :object_states
	end

	Base.template_file = "lib/templates/base.mustache"
end