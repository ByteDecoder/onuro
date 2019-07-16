# frozen_string_literal: true

module Onuro
  class ContextBuilder
    attr_accessor :context

    def initialize
      self.context = Context.new
    end

    def add(key, value)
      context.add(key, value)
    end

    def self.build
      builder = new
      yield builder if block_given?
      builder.context
    end
  end
end
