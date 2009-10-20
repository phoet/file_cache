require 'file_cache'
require 'activesupport'

include FileCache

module ActiveSupport
  module Cache
    class RailsFileCache < Store
      private
        def log(operation, key, options)
          puts("Cache #{operation}: #{key}#{options ? " (#{options.inspect})" : ""}")
        end
    end
  end 
end