# frozen_string_literal: true

module Onuro
  class Event
    include Loggable
    include ExecutionResult

    attr_reader :name, :ruleset_stage
    attr_accessor :event_strategy

    def name=(name)
      raise InvalidEventNameException if name.empty?

      @name = name.downcase.to_sym
    end

    def initialize(name, ruleset_stage: [], event_strategy: DefaultEventStrategy.new)
      self.name = name
      self.event_strategy = event_strategy
      @ruleset_stage = ruleset_stage
    end

    def add_ruleset_stage(ruleset_stage)
      @ruleset_stage += ruleset_stage
    end

    def add_rule_stage(rule_stage)
      ruleset_stage << rule_stage
    end

    def execute(context = {})
      result = execution_flow(context)
      execution_result(SUCCESSFUL, result[:processed], result[:failed])
    end

    private

    def execution_result(status, processed, failed)
      result = Hash.new(0)
      result[:status] = status
      result[:event_name] = name
      result[:processed_rules] = processed
      result[:failed_rules] = failed
      result
    end

    def execution_flow(context = {})
      result = Hash.new(0)
      ruleset_stage.each do |rule_stage|
        proc_exec = event_strategy.before_rule_exec(rule_stage, context)
        next unless proc_exec

        result_status = rule_stage.rule.new.execute(context)
        event_strategy.after_rule_exec(rule_stage, context, result)

        result[:processed] += 1 if result_status == SUCCESSFUL
        result[:failed] += 1 if result_status == FAILURE
      end
      result
    end
  end
end
