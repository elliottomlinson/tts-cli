require 'mustache'

module Templates
	class Base < Mustache
		attr_accessor :object_states
	end

	Base.template_file = File.join(__dir__, "base.mustache")

	class Config < Mustache
		attr_accessor :sessionName
	end

	Config.template_file = File.join(__dir__, "config.mustache")
end