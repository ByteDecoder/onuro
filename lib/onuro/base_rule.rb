# frozen_string_literal: true

module Onuro
  class BaseRule
    include ExecutionResult
    include Loggable

    def execute(_context = {})
      SUCCESSFUL
    end
  end
end
