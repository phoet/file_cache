$:.unshift File.join(File.dirname(__FILE__),'..','..','lib')

require 'test/unit'
require 'rails_file_cache'

class TestRailsFileCache < Test::Unit::TestCase

  def setup
    @cache = ActiveSupport::Cache::RailsFileCache.new
    @value = "value"
    @key = "key"
    @matcher = "matcher"
    @options = {:option => 'any'}
  end
  
  def test_read
    @cache.read(@key, @options)
  end

  def test_write
    @cache.write(@key, @value, @options)
  end

  def test_delete
    @cache.delete(@key, @options)
  end

  def test_delete_matched
    @cache.delete_matched(@matcher, @options)
  end

  def test_exist?
    @cache.exist?(@key, @options)
  end
  
end