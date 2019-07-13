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
    end

    def event?(event_name)
      events.key?(event_name)
    end

    def delete_event!(event_name)
      result = events.delete(event_name)
      raise InvalidEventNameException unless result
    end

    def execute(_context = {})
      ['Still WIP']
    end
  end
end
