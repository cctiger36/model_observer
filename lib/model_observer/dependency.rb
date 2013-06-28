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
  end
end
