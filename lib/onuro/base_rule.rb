# frozen_string_literal: true

require 'onuro/execution_result'

module Onuro
  class BaseRule
    include ExecutionResult

    def execute(_context = {})
      SUCCESSFUL
    end
  end
end
