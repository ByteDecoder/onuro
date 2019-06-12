# frozen_string_literal: true

require 'onuro/execution_result'

module Onuro
  class BaseRule
    include ExecutionResult

    def execute
      SUCCESSFUL
    end
  end
end
