[![Version         ][rubygems_badge]][rubygems]
[![Maintainability](https://api.codeclimate.com/v1/badges/adf3d29832220efbd6fc/maintainability)](https://codeclimate.com/github/ByteDecoder/onuro/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/adf3d29832220efbd6fc/test_coverage)](https://codeclimate.com/github/ByteDecoder/onuro/test_coverage)
# Onuro

Workflow Engine based in events that execute a collection of rules defined in the event configuration definition

## Installation

Add this line to your application's Gemfile:

```bash
gem 'onuro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install onuro

## Usage

The easiest way to load *Events + Rules* configuration in the **Engine** is using the configuration blocks. Its important to mention these global pre-configured events, would not be changed when in runt-time an **engine instance** is begin fetched with new events.

```ruby
class Rule1 < Onuro::BaseRule; end
class Rule2 < Onuro::BaseRule; end
class Rule3 < Onuro::BaseRule; end
class MyCustomEventStrategy < Onuro::DefaultEventStrategy
  # override here the methods to execute your custom logic before/after each rule
end

# Onuro::Engine configuration block
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
    event.add_ruleset_stage Onuro::RuleStage.default_ruleset_stage_factory([Rule1, Rule2, Rule3])
  end
end

# When the *engine object is created, will fetch the pre-configured events for instant use,
# saving the boilerplate object setup for your common events and rule sets.
exec_result = Onuro::Engine.new.execute(:event_four)
```

### Context

This is the instance object that will be passed through all the event execution process. Here you can pass key/value params that will be help you while the **Rules** are being executed. Things like *member_id*, *current_date* (you name it) will be passed from the engine to all the way down until the end of the execution. Since is a reference object, you can add new key/value states during the *ruleset* execution.

One way:
```ruby
Onuro::Engine.new.execute(:my_event) do |context|
  context.add(:member_id, 1)
  context.add(:current_date, '01/01/2019')
end
```

Another way:
```ruby
context = Onuro::ContextBuilder.build do |context|
    context.add(:member_id, 1)
    context.add(:current_date, '01/01/2019')
end

Onuro::Engine.new.execute(:my_event, context)
```

Another way with *double splat* operators in the *Context* constructor:
```ruby
context = Onuro::Context.new(member_id: 1, current_date: '01/01/2019')

Onuro::Engine.new.execute(:my_event, context)
```

**Note:** If you do not provide a context, an empty one will be created.

### Engine

The **engine** is the object that can hold a list of **events**, where the desired **event** is executed and additionally, you can provide a **context** object with helpful key/value data that will help you in your **rule** processing.

```ruby
context = Onuro::Context.new(...your data..)
engine = Onuro::Engine.new

engine.add_events([event1, event2])
engine.new.execute(:my_event, context)
```

### Rules

Are the foundation building blocks of the *rulesets* and this is where you can place your **logic** divided in segments(**rules**).

All the rules processed by the engine is recommended to inherith from **Onuro::BaseRule** since this base class give you access to the **logger** support and easy access to the **ExecutionResult** constants used by the engine. Basically you need to override/implement **execute** method accepting as input an **context** object. The **rule** need to return and **ExecutionResult** constant. (More about extending this later in this README)

A collection of *rules* is holded by an **event** object

```ruby
class MyRule < Onuro::BaseRule
  def execute(context)
    context[:mul_result] = context[:first_operand] * context[:second_operand]
    SUCCESSFUL
  end
end

ruleset_stage = Onuro::RuleStage.default_ruleset_stage_factory([MyRule])
event.add_ruleset_stage(ruleset_stage)
```

Also, you can execute a single rule without using the full **Onuro::Engine**

```ruby
MyRule.new.execute(context)
```

### RuleStage

Since *Onuro* allows the rule execution, you can diseable or add a particular **order** of execution to all the rules in a rulseset, the **RuleStage** class help us to do that. You cannot add the **Rule** object instances directly in the event, without adding first each rule into a **RuleStage** object.

```ruby
event.add_ruleset_stage [
  Onuro::RuleStage.new(rule: Rule1, enabled: true, order: 1),
  Onuro::RuleStage.new(rule: Rule3, enabled: true, order: 2)
]
```

If you want to add all the rules enabled by default, and the execution order will be based in the order that you define the ruleset collection, you can use a **RuleStage** factory to save all these object setup:

```ruby
event.add_ruleset_stage Onuro::RuleStage.default_ruleset_stage_factory([Rule1, Rule2, Rule3])
```

### Events

Events are the component that hold an *rulset stage* composed of a list of rules and their settings for execution. The easiest way to define and event is creating the instance object always with the event name required. In order to create complex events with more settings, take a look to the *Event Builder* section.

```ruby
event = Onuro::Event.new(:my_event)
engine.add_event(event)
engine.execute(:my_event)
```

### Event Builder

An easier way to create an event, is using the **EventBuilder** class based on the *builder pattern*. This gives a lot of flexibility when you are creating the events and avoid having a lot or parameters in the constructor and assembling  all the event internals, and easy to to be plugged in you **Engine** class instance.

```ruby
event = Onuro::EventBuilder.build(:test_ruleset) do |builder|
          builder.add_ruleset_stage([rule1, rule2, rule3])
          builder.add_event_strategy(MyCustomEventStrategy.new)
          builder.exec_order(:desc)
          buidler.ignore_diseabled
        end

engine.add_event(event)
engine.execute(:test_ruleset)
```

### Event Strategies

Events allow you to implement your custom strategy, to control what happens before and after the rule is executed in the event. By default Onuro provides a default strategy:

```ruby
module Onuro
  class DefaultEventStrategy
    def before_rule_exec(_rule_stage, _context)
      true
    end

    def after_rule_exec(_rule_stage, _context, _result)
      true
    end
  end
end
```

You only need to implement the methods **before_rule_exec** and **after_rule_exec** in your custom class returning a boolean value. Basically, this is the *strategy pattern*.

If **before_rule_exec** returns false, skip the current rule execution and move to the next one in the ruleset list.

### ExecutionResult

TBD

### Determining succcess or failure of the event processing

TBD

### Logging

TBD

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ByteDecoder/onuro.


Copyright (c) 2019 [Rodrigo Reyes](https://twitter.com/bytedecoder) released under the MIT license
