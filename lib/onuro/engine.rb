# frozen_string_literal: true

module Onuro
  class Engine
    include Loggable

    attr_accessor :events

    class << self
      # Setter for shared global objects
      attr_writer :configuration
    end

    # Returns the global [EngineConfiguration](Onuro/EngineConfiguration) object. While
    # you _can_ use this method to access the configuration, the more common
    # convention is to use [Onuro::Engine.configure](Onuro::Engine#configure-class_method).
    #
    # @example
    #     Onuro::Engine.configuration.tbd = 1234
    # @see Onuro::Engine.configure
    # @see Onuro::EngineConfiguration
    def self.configuration
      @configuration ||= Onuro::EngineConfiguration.new
    end

    # Users must invoke this if they want to have the configuration reset when
    # they use the runner multiple times within the same process. Users must deal
    # themselves with re-configuration of Onuro::Engine before run.
    def self.reset
      @configuration = nil
    end

    # Yields the global configuration to a block.
    # @yield [EngineConfiguration] global configuration
    #
    # @example
    #     Onuro::Engine.configure do |config|
    #       config.events 'documentation'
    #     end
    # @see Onuro::EngineConfiguration
    def self.configure
      yield configuration if block_given?
    end

    def initialize
      # Loading events from the global configuration, if we have it
      # We need to clone, otherwise will get the smae obejct_id reference
      self.events = Engine.configuration.events.clone
    end

    def self.instance
      new
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

    def execute(event_name, context = Context.new)
      raise InvalidEventNameException unless event?(event_name)

      context.data.merge! ContextBuilder.build.data
      events[event_name].execute(context)
    end
  end
end
