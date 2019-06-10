# frozen_string_literal: true

require 'onuro/version'
require 'onuro/engine'

module Onuro
  class Error < StandardError; end
  class InvalidEventNameException < StandardError; end

  # Your code goes here...
  Event = Struct.new(:name, :rules)
  Rule = Struct.new(:rule, :enabled, :order)
end
