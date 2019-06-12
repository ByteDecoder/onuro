# frozen_string_literal: true

require 'spec_helper'
require 'onuro'

module Onuro
  RSpec.describe BaseRule do
    describe '.execute' do
      it 'should return SUCCESS' do
        result = BaseRule.new.execute
        expect(result).to eq(ExecutionResult::SUCCESSFUL)
      end
    end
  end
end
