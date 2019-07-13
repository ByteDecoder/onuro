# frozen_string_literal: true

module Onuro
  class Engine
    include Logging

    attr_accessor :events

    def initialize
      self.events = []
    end

    def add_event(event)
      events << event
    end

    def event?(event_name)
      events.each do |event|
        return true if event.name == event_name
      end
      false
    end

    def delete_event!(event_name)
      events.each do |event|
        if event.name == event_name
          events.delete(event)
          return true
        end
      end
      raise InvalidEventNameException
    end

    def execute(_context = {})
      ['Still WIP']
    end
  end
end
