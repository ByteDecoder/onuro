# frozen_string_literal: true

module Onuro
  class RuleStage
    attr_reader :rule, :enabled, :order

    def initialize(options = {})
      @rule = options[:rule]
      @enabled = options[:enabled]
      @order = options[:order]
    end
  end
end
