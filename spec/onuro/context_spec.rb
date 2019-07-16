# frozen_string_literal: true

require 'spec_helper'
require 'onuro'

module Onuro
  RSpec.describe Context do
    it 'is created successfullly' do
      context = Context.new(param1: 1, param2: 'two')
      expect(context.data[:param1]).to eq(1)
      expect(context.data[:param2]).to eq('two')
    end

    it 'creates successfully a context with the builder' do
      context = ContextBuilder.build do |builder|
        builder.add(:param1, 1)
        builder.add(:param2, 'lusx')
      end
      expect(context.data.size).to eq(2)
    end
  end
end
