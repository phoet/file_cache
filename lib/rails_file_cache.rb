require 'activesupport'
require 'file_helper'

# = RailsFileCache
#
# Simple Caching implementation that persists the content into a temporary file.
# 
# The only cool stuff is that you can optinally define the time to 
# live via the option +:expires_in+ which defaults to 30.seconds if not set.
#
# == Example
#
#   cache.fetch(@key, :expires_in=>30.seconds) do
#     some_action_that_should_be_cached_for_configured_time
#   end
#
module ActiveSupport
  module Cache
    class RailsFileCache < Store

      # reads cached value for key
      # default-caching for 30.seconds can be configured through the +:expires_in+ option
      def read(key, options = {})
        log("read", key, options)
        name = file_name key
        expires_in = (options[:expires_in] || 30.seconds)
        log("reading from file=#{name} with expires=#{expires_in}", key, options)
        File.read(name) if FileHelper.not_cached_or_to_old?(name, expires_in)
      end

      # writes value to tmp-file and returns the value again
      def write(key, value, options = nil)
        log("write", key, options)
        name = file_name key
        log("writing value=#{value} to file=#{name}", key, options)
        File.open(name, "w") { |file| file << value }
        value
      end

      # deletes the cached value for given +key+
      def delete(key, options = nil)
        log("delete", key, options)
        name = file_name key
        log("deleting file=#{name}", key, options)
        File.delete name if File.exists? name
      end

      # deletes the cached value for all keys matching +matcher+
      def delete_matched(matcher, options = nil)
        log("delete matched", matcher.inspect, options)
        Dir[FileHelper.tmpdir + "/*.#{FileHelper.extension}"].grep(matcher) do |match| 
          log("deleting file=#{match}", matcher.inspect, options)
          File.delete match
        end.size
      end

      # checks if a cached value exists for given +key+
      def exist?(key, options = nil)
        log("exist?", key, options)
        name = file_name key
        log("checking file=#{name} exists", key, options)
        File.exists? name
      end

      private

      def file_name(key)
        FileHelper.file_cache_name FileHelper.tmpdir, key
      end

      def log(operation, key, options)
        if  !@silence && !@logger_off
          message = "Cache #{operation}: #{key}#{options ? " (#{options.inspect})" : ""}"
          if logger 
            logger.debug message
          else
            puts message
          end
        end
      end

    end
  end 
end