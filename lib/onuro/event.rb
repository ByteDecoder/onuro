# frozen_string_literal: true

module Onuro
  class Event
    include Logging

    attr_reader :name
    attr_accessor :ruleset

    def name=(name)
      @name = name.downcase.to_sym
    end

    def initialize(name, ruleset)
      self.name = name
      self.ruleset = ruleset
    end

    def add_rule_stage(rule_stage)
      ruleset << rule_stage
    end
  end
end
