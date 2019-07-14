# frozen_string_literal: true

require 'onuro'

module Onuro
  class Rule1 < BaseRule; end
  class Rule2 < BaseRule; end
  class Rule3 < BaseRule
    def execute(_context)
      FAILURE
    end
  end

  RSpec.describe 'Basic Workflow Test' do
    subject { engine.execute(:test_ruleset, legion: true, inmortal: true) }

    let(:engine) { Engine.new }
    let(:rule1) { RuleStage.new(rule: Rule1, enabled: true, order: 1) }
    let(:rule2) { RuleStage.new(rule: Rule2, enabled: true, order: 1) }
    let(:rule3) { RuleStage.new(rule: Rule3, enabled: true, order: 1) }
    let(:event1) do
      EventBuilder.build(:test_ruleset) do |builder|
        builder.add_ruleset_stage([rule1, rule2, rule3])
      end
    end

    before { engine.add_event(event1) }

    describe '.execute' do
      it 'executes sucessfully' do
        result = subject
        expect(result[:processed_rules]).to eq(2)
        expect(result[:failed_rules]).to eq(1)
        expect(result[:event_name]).to eq(:test_ruleset)
        expect(result[:status]).to eq(ExecutionResult::SUCCESSFUL)
      end
    end
  end
end
