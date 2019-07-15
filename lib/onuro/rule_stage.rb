# frozen_string_literal: true

module Onuro
  class RuleStage
    attr_reader :rule, :enabled, :order

    def initialize(rule:, enabled:, order:)
      @rule = rule
      @enabled = enabled
      @order = order
    end

    def self.default_ruleset_stage_factory(rules)
      ruleset_stage = []
      order = 1
      rules.each do |rule|
        ruleset_stage << RuleStage.new(rule: rule, enabled: true, order: order)
        order += 1
      end
      ruleset_stage
    end
  end
end
