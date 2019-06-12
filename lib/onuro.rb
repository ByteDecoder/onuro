# frozen_string_literal: true

require 'onuro/version'
require 'onuro/engine'
require 'onuro/base_rule'
require 'onuro/execution_result'

module Onuro
  class Error < StandardError; end
  class InvalidEventNameException < StandardError; end

  # Your code goes here...
  Event = Struct.new(:name, :rules)
  Rule = Struct.new(:rule, :enabled, :order)
end
