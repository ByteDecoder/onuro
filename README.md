# Onuro

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/onuro`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'onuro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install onuro

## Usage

The easiest way to load Event + Rules configuration in the **Engine** is using the configuration blocks. Its important to mention these global pre-configured events, would be changed when in runt-time an **engine instance** is begin fetched with new events.

```ruby
class Rule1 < Onuro::BaseRule; end
class Rule2 < Onuro::BaseRule; end
class Rule3 < Onuro::BaseRule; end
class MyCustomEventStrategy < Onuro::DefaultEventStrategy; end


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
```

### Engine

### Rule

### RuleStage

### Events

Events are the component that hold an *rulset stage* composed of a list of rules and their settings for execution. The easiest way to define and event is creating the instance object always with the event name required. In order to create complex events with more settings, take a look to the *Event Builder* section.

```ruby
event = Event.new(:my_event)
engine.add_event(event)
engine.execute(:my_event)
```

### Event Builder

An easier way to create an event, is using the **EventBuilder** class based on the *builder pattern*. This gives a lot of flexibility when you are creating the events and avoid having a lot or parameters in the constructor and assembling  all the event internals, and easy to to be plugged in you **Engine** class instance.

```ruby
event = EventBuilder.build(:test_ruleset) do |builder|
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ByteDecoder/onuro.
