# frozen_string_literal: true

require 'onuro/version'
require 'onuro/engine'
require 'onuro/event'
require 'onuro/base_rule'
require 'onuro/execution_result'
require 'onuro/logging'

module Onuro
  class Error < StandardError; end
  class InvalidEventNameException < StandardError; end

  # Your code goes here...
  RuleStage = Struct.new(:rule, :enabled, :order)
end
