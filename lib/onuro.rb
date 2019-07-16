# frozen_string_literal: true

require 'onuro/version'
require 'onuro/execution_result'
require 'onuro/logging'
require 'onuro/engine_configuration'
require 'onuro/context_builder'
require 'onuro/context'
require 'onuro/engine'
require 'onuro/default_event_strategy'
require 'onuro/event_builder'
require 'onuro/event'
require 'onuro/base_rule'
require 'onuro/rule_stage'

# Namespace for all Onuro code.
module Onuro
  class Error < StandardError; end
  class InvalidEventNameException < StandardError; end
end
