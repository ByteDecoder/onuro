# frozen_string_literal: true

module Onuro
  class EventBuilder
    attr_accessor :event

    def initialize(name)
      self.event = Event.new(name)
    end

    def add_event_strategy(event_strategy)
      event.event_strategy = event_strategy
    end

    def add_ruleset_stage(ruleset_stage)
      event.add_ruleset_stage(ruleset_stage)
    end

    def add_rule_stage(rule_stage)
      event.add_rule_stage(rule_stage)
    end

    def exec_order(order)
      # can be :asc, :desc, :none by default (order is as rules were introduced
      # in the ruleset_stage list)
    end

    def ignore_diseabled
      # sets to true and all the diseablked rules will be executed
      # default should be false, so diseabled rules will not be executed
    end

    def self.build(name)
      builder = new(name)
      yield builder
      builder.event
    end
  end
end
