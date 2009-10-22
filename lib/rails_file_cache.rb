require 'activesupport'
require 'file_helper'

module ActiveSupport
  module Cache
    class RailsFileCache < Store

      def read(key, options = nil)
        log("read", key, options)
        name = file_name key
        puts name
      end

      def write(key, value, options = nil)
        log("write", key, options)
      end

      def delete(key, options = nil)
        log("delete", key, options)
      end

      def delete_matched(matcher, options = nil)
        log("delete matched", matcher.inspect, options)
      end

      def exist?(key, options = nil)
        log("exist?", key, options)
      end
      
      private
      
      def file_name(key)
        FileHelper::file_cache_name FileHelper::tmpdir, key
      end
      
        def log(operation, key, options)
          puts("Cache #{operation}: #{key}#{options ? " (#{options.inspect})" : ""}")
        end
    end
  end 
end