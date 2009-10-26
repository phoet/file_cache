require 'test_helper'
require 'rails_file_cache'

class TestRailsFileCache < Test::Unit::TestCase

  def setup
    @cache = ActiveSupport::Cache::RailsFileCache.new
    @value = "value"
    @key = "key"
    @options = {:option => 'any'}
  end

  def test_read_write
    @cache.delete(@key, @options)
    assert_nil(@cache.read(@key, @options))
    @cache.write(@key, @value, @options)
    assert_equal(@value, @cache.read(@key, @options))
    assert_equal(nil, @cache.read(@key, :expires_in=>0.seconds))
  end

  def test_write
    assert_equal(@value, @cache.write(@key, @value, @options))
  end

  def test_delete_exists
    assert_equal(1, @cache.delete(@key, @options))
    assert_equal(false, @cache.exist?(@key, @options))
  end

  def test_delete_matched
    @cache.write('aaaa', @value, @options)
    @cache.write('aaa', @value, @options)
    @cache.write('aa', @value, @options)
    assert_equal(3, @cache.delete_matched(/aa+/, @options))
    assert_nil(@cache.read('aaaa', @options))
    assert_nil(@cache.read('aaa', @options))
    assert_nil(@cache.read('aa', @options))
  end

  def test_create_exist?
    @cache.write(@key, @value, @options)
    assert_equal(true, @cache.exist?(@key, @options))
  end

end