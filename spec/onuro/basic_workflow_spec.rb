# frozen_string_literal: true

require 'onuro'

module Onuro
  class Rule1 < BaseRule; end
  class Rule2 < BaseRule; end

  RSpec.describe 'Basic Workflow Test' do
    let(:engine) { Engine.new }
    let(:rule1) { RuleStage.new(rule: Rule1, enabled: true, order: 1) }
    let(:rule2) { RuleStage.new(rule: Rule2, enabled: true, order: 1) }
    let(:event1) { Event.new(:test_ruleset, [rule1, rule2]) }

    before { engine.add_event(event1) }

    subject { engine.execute(:test_ruleset, legion: true, inmortal: true) }

    describe '.execute' do
      it 'should execute sucessfully' do
        result = subject
        expect(result[:rules_processed]).to eq(2)
        expect(result[:event_name]).to eq(:test_ruleset)
        expect(result[:status]).to eq(ExecutionResult::SUCCESSFUL)
      end
    end
  end
end
