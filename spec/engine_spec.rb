# frozen_string_literal: true

require 'onuro'

RSpec.describe Onuro::Engine do
  describe '.execute' do
    it 'should execute sucessfully' do
      expect { Onuro::Engine.new.execute }.to_not raise_error
    end
  end
end
