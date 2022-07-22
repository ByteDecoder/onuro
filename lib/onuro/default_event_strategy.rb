# frozen_string_literal: true

module Onuro
  class EventStrategyBase
    def before_rule_exec(_rule_stage, _context)
      raise NotImplementedError
    end

    def after_rule_exec(_rule_stage, _context, _result)
      raise NotImplementedError
    end
  end
  
  class DefaultEventStrategy < EventStrategyBase
    def before_rule_exec(_rule_stage, _context)
      true
    end

    def after_rule_exec(_rule_stage, _context, _result)
      true
    end
  end
end
