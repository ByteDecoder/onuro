# frozen_string_literal: true

module Onuro
  class Context
    attr_reader :data

    def initialize(**options)
      @data = Hash.new(0)
      @data.merge!(options)
    end

    def add(key, value)
      data[key] = value
    end
  end
end
