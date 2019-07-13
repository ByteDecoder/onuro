# frozen_string_literal: true

require 'onuro'

module Onuro
  RSpec.describe Engine do
    describe '.execute' do
      it 'should not execute successfully if event is not registered in the engine' do
        expect { Engine.new.execute(:legion_rule) }.to raise_error(InvalidEventNameException)
      end
    end

    describe '.event?' do
      it 'should return false if event is not loaded in the engine' do
        engine = Engine.new
        expect(engine.event?(:my_event)).to be_falsey
      end

      it 'should return true if event is loaded in the engine' do
        event = Event.new(:my_event, [])
        engine = Engine.new
        engine.add_event(event)
        expect(engine.event?(:my_event)).to be_truthy
      end
    end

    describe '.delete_event!' do
      it 'executes successfully if the event_name exist' do
        event = Event.new(:my_event, [])
        engine = Engine.new
        engine.add_event(event)
        expect { engine.delete_event!(:my_event) }.to_not raise_error
      end

      it 'raises an exception if the event_name does not exist' do
        engine = Engine.new
        expect do
          engine.delete_event!(:my_event)
        end.to raise_error(InvalidEventNameException)
      end
    end
  end
end
