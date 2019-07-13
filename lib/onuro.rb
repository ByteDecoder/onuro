# frozen_string_literal: true

require 'onuro/version'
require 'onuro/execution_result'
require 'onuro/logging'
require 'onuro/engine'
require 'onuro/event'
require 'onuro/base_rule'
require 'onuro/rule_stage'

module Onuro
  class Error < StandardError; end
  class InvalidEventNameException < StandardError; end
end
