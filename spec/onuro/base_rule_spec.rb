# frozen_string_literal: true

require 'spec_helper'
require 'onuro'

module Onuro
  class TestRule < BaseRule
    def execute(context = {})
      logger.info "We are here with #{context[:legion]}"
      SUCCESSFUL
    end
  end

  RSpec.describe TestRule do
    describe '.execute' do
      it 'should return SUCCESSFUL and log the info' do
        result = TestRule.new.execute(legion: 'HeavenFall')
        expect(result).to eq(ExecutionResult::SUCCESSFUL)
      end
    end
  end

  RSpec.describe BaseRule do
    describe '.execute' do
      it 'should return SUCCESSFUL' do
        result = BaseRule.new.execute
        expect(result).to eq(ExecutionResult::SUCCESSFUL)
      end
    end
  end
end
