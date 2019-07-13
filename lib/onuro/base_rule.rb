# frozen_string_literal: true

module Onuro
  class BaseRule
    include ExecutionResult
    include Logging

    def execute(_context = {})
      SUCCESSFUL
    end
  end
end
