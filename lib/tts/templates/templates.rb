require 'mustache'

module Templates
  class Base < Mustache
    attr_accessor :object_states
  end

  Base.template_file = File.join(__dir__, 'base.mustache')

  class Deck < Mustache
    attr_accessor :object_states
  end

  Deck.template_file = File.join(__dir__, 'deck.mustache')

  class Config < Mustache
    attr_accessor :sessionName
  end

  Config.template_file = File.join(__dir__, 'config.mustache')

  class States < Mustache
    attr_accessor :states
  end

  States.template_file = File.join(__dir__, 'states.mustache')
end
