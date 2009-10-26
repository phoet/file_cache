require 'test_helper'
require 'file_helper'

class TestFileHelper < Test::Unit::TestCase

  def setup
    @filename = 'timestamp'
    FileUtils.touch @filename
  end

  def teardown
    FileUtils.rm @filename
  end

  def test_file_cache_name_with_strange_tokens_only_characters_remain
    assert_equal('tmp/a_b_c.fc', FileHelper.file_cache_name('tmp', :'a+b*c'), 'Expected token to be just charactes and underscores!')
  end

  def test_file_checking_working
    assert(FileHelper.not_cached_or_to_old?(@filename, 1), 'Expected File to be existing and not that old!')
    assert(!FileHelper.not_cached_or_to_old?(@filename, 0), 'Expected File to be too old!')
    assert(!FileHelper.not_cached_or_to_old?('other', 1), 'Expected File not to exist!')
  end

end