# frozen_string_literal: true

class Onuro::Engine
  def initialize
    @events = []
  end

  def add_event(event)
    @events << event
  end

  def event?(event_name)
    @events.each do |event|
      return true if event.name == event_name
    end
    false
  end

  def execute
    ['Still WIP']
  end
end
