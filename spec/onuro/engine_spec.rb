# frozen_string_literal: true

require 'onuro'

module Onuro
  RSpec.describe Engine do
    describe '.execute' do
      it 'does not execute successfully if event is not registered in the engine' do
        expect { Engine.new.execute(:legion_rule) }.to raise_error(InvalidEventNameException)
      end
    end

    describe '.event?' do
      it 'returns false if event is not loaded in the engine' do
        engine = Engine.new
        expect(engine).not_to be_event(:my_event)
      end

      it 'returns true if event is loaded in the engine' do
        event = Event.new(:my_event)
        engine = Engine.new
        engine.add_event(event)
        expect(engine).to be_event(:my_event)
      end
    end

    describe '.delete_event!' do
      it 'executes successfully if the event_name exist' do
        event = Event.new(:my_event)
        engine = Engine.new
        engine.add_event(event)
        expect { engine.delete_event!(:my_event) }.not_to raise_error
      end

      it 'raises an exception if the event_name does not exist' do
        engine = Engine.new
        expect do
          engine.delete_event!(:my_event)
        end.to raise_error(InvalidEventNameException)
      end
    end

    describe '.add_events' do
      let(:event1) { Event.new(:event_one) }
      let(:event2) { Event.new(:event_two) }

      it 'as collection of events into the engine instance' do
        engine = Engine.new.add_events([event1, event2])
        expect(engine.events.size).to eq(2)
      end
    end
  end
end
