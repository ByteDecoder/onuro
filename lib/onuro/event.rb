# frozen_string_literal: true

class Onuro::Event
  include Onuro::Logging

  attr_accessor :name, :ruleset

  def initialize(name, ruleset)
    self.name = name
    self.ruleset = ruleset
  end

  def add_rule_stage(rule_stage)
    ruleset << rule_stage
  end
end
