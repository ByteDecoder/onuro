# frozen_string_literal: true

require 'active_support/logger'

module Onuro
  module Logging
    def logger
      Logging.logger
    end

    # Global, memoized, lazy initialized instance of a logger
    def self.logger
      @logger ||= ActiveSupport::Logger.new(logger_file, 10, 1_024_000)
    end

    def self.logger_file
      'log/onuro_engine.log'
    end
  end
end
