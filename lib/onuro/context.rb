# frozen_string_literal: true

module Onuro
  class Context
    attr_reader :data

    def [](key)
      data[key]
    end

    def []=(key, value)
      data[key] = value
    end

    def initialize(**options)
      @data = Hash.new(0)
      @data.merge!(options)
    end

    def add(key, value)
      data[key] = value
    end
  end
end
