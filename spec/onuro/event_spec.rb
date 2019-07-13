# frozen_string_literal: true

require 'spec_helper'
require 'onuro'

module Onuro
  RSpec.describe Event do
    describe 'event object creation' do
      it 'should not allow event creation with empty name' do
        expect { Event.new('') }.to raise_error(InvalidEventNameException)
      end
    end
  end
end
