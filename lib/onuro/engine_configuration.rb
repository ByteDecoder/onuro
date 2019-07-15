# frozen_string_literal: true

module Onuro
  class EngineConfiguration
    attr_reader :events

    def initialize
      @events = Hash.new(0)
    end

    def add_event(event_name)
      event = EventBuilder.build(event_name)
      events[event.name] = event
    end
  end
end
