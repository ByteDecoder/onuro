# frozen_string_literal: true

module Onuro
  class RuleStage
    attr_reader :rule, :enabled, :order

    def initialize(rule:, enabled:, order:)
      @rule = rule
      @enabled = enabled
      @order = order
    end
  end
end
