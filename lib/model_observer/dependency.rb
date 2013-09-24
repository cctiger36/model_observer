module ModelObserver
  module Dependency
    def active_record?
      @active_record ||= begin
        require 'active_record'
        true
      rescue LoadError
        false
      end
    end

    def active_record3?
      active_record? && ::ActiveRecord::VERSION::MAJOR == 3
    end

    def active_record4?
      active_record? && ::ActiveRecord::VERSION::MAJOR == 4
    end
  end
end
