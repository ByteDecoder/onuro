# frozen_string_literal: true

module Onuro
  class Engine
    include Logging

    attr_accessor :events

    def initialize
      self.events = Hash.new(0)
    end

    def add_event(event)
      events[event.name] = event
      self
    end

    def add_events(new_events)
      new_events.each { |event| add_event(event) }
      self
    end

    def event?(event_name)
      events.key?(event_name)
    end

    def delete_event!(event_name)
      result = events.delete(event_name)
      raise InvalidEventNameException unless result
    end

    def execute(event_name, context = {})
      raise InvalidEventNameException unless event?(event_name)

      events[event_name].execute(context)
    end
  end
end
