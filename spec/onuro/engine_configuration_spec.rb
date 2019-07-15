# frozen_string_literal: true

require 'spec_helper'
require 'onuro'

RSpec.describe Onuro::Engine do
  before { EngineTest.configure }

  after { described_class.reset }

  it 'loads the configuration correctly with Onuro::Enginge object is created' do
    expect(described_class.configuration.events.size).to eq(4)
    expect(described_class.configuration.events).to be_key(:event_one)
    expect(described_class.configuration.events).to be_key(:event_two)
    expect(described_class.configuration.events).to be_key(:event_three)
    expect(described_class.configuration.events).to be_key(:event_four)

    expect(described_class.configuration.events).not_to be_key(:event_legion)
  end

  it 'when creation Engine class, should load all the events defined in the Global Configuration' do
    engine = described_class.new
    expect(engine.events.size).to eq(4)
  end
end

class Rule1 < Onuro::BaseRule; end
class Rule2 < Onuro::BaseRule; end
class Rule3 < Onuro::BaseRule; end
class MyCustomEventStrategy < Onuro::DefaultEventStrategy; end

class EngineTest
  def self.configure
    Onuro::Engine.configure do |config|
      config.add_event(:event_one) do |event|
        event.add_ruleset_stage [
          Onuro::RuleStage.new(rule: Rule1, enabled: true, order: 1),
          Onuro::RuleStage.new(rule: Rule3, enabled: true, order: 2)
        ]
        event.add_event_strategy(MyCustomEventStrategy.new)
        event.exec_order(:desc)
        event.ignore_diseabled
      end

      config.add_event(:event_two) do |event|
        event.add_ruleset_stage [
          Onuro::RuleStage.new(rule: Rule1, enabled: true, order: 1),
          Onuro::RuleStage.new(rule: Rule2, enabled: true, order: 2)
        ]
      end

      config.add_event(:event_three) do |event|
        event.add_ruleset_stage [Onuro::RuleStage.new(rule: Rule1, enabled: true, order: 1)]
      end

      config.add_event(:event_four) do |event|
        event.add_rule_stage Onuro::RuleStage.default_ruleset_stage_factory([Rule1, Rule2, Rule3])
      end
    end
  end
end
