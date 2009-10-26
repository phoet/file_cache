require 'activesupport'
require 'file_helper'

module ActiveSupport
  module Cache
    class RailsFileCache < Store

      def read(key, options = {})
        log("read", key, options)
        name = file_name key
        expires_in = (options[:expires_in] || 30.seconds)
        puts "reading from file=#{name} with expires=#{expires_in}"
        File.read(name) if FileHelper.not_cached_or_to_old?(name, expires_in)
      end

      def write(key, value, options = nil)
        log("write", key, options)
        name = file_name key
        puts "writing value=#{value} to file=#{name}"
        File.open(name, "w") { |file| file << value }
        value
      end

      def delete(key, options = nil)
        log("delete", key, options)
        name = file_name key
        puts "deleting file=#{name}"
        File.delete name if File.exists? name
      end

      def delete_matched(matcher, options = nil)
        log("delete matched", matcher.inspect, options)
        Dir[FileHelper.tmpdir + "/*.#{FileHelper.extension}"].grep(matcher) do |match| 
          puts "deleting file=#{match}"
          File.delete match
        end.size
      end

      def exist?(key, options = nil)
        log("exist?", key, options)
        name = file_name key
        puts "checking file=#{name} exists"
        File.exists? name
      end

      private

      def file_name(key)
        FileHelper.file_cache_name FileHelper.tmpdir, key
      end

      def log(operation, key, options)
        puts("Cache #{operation}: #{key}#{options ? " (#{options.inspect})" : ""}")
      end
      
    end
  end 
end