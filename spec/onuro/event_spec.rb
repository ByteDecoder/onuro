# frozen_string_literal: true

require 'spec_helper'
require 'onuro'

module Onuro
  RSpec.describe Event do
    describe 'event object creation' do
      it 'should not allow event creation with empty name' do
        expect { Event.new('') }.to raise_error(InvalidEventNameException)
      end

      it 'should allow the event creation with a name' do
        expect { Event.new(:legion_ruleset) }.to_not raise_error
      end
    end

    describe '.add_rule_stage' do
      it 'should add rule stage into the event ruleset' do
        event = Event.new(:my_event)
        event.add_rule_stage(RuleStage.new(rule: BaseRule))
        expect(event.ruleset_stage.size).to eq(1)
      end
    end
  end
end
