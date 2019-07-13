# frozen_string_literal: true

module Onuro
  class Event
    include Logging
    include ExecutionResult

    attr_reader :name
    attr_accessor :ruleset

    def name=(name)
      raise InvalidEventNameException if name.empty?

      @name = name.downcase.to_sym
    end

    def initialize(name, ruleset = [])
      self.name = name
      self.ruleset = ruleset
    end

    def add_rule(rule_stage)
      ruleset << rule_stage
    end

    def execute(context = {})
      rules_processed = 0
      ruleset.each do |rule_stage|
        rule_stage.rule.new.execute(context)
        rules_processed += 1
      end

      result = Hash.new(0)
      result[:status] = SUCCESSFUL
      result[:event_name] = name
      result[:rules_processed] = rules_processed
      result
    end
  end
end
