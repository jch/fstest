require 'test_helper'

class FSTestTest < MiniTest::Unit::TestCase
  include FSTest

  def setup
    @klass = Class.new { include FSTest }
    @instance = @klass.new
  end

  def test_include_adds_base_directory_attribute
    assert @instance.respond_to? :base_directory
    assert @instance.respond_to? :base_directory=
    assert @instance.base_directory = '/tmp'
    assert_equal '/tmp', @instance.base_directory
  end

  def test_base_directory_is_expanded
    @instance.base_directory = '~'
    assert_equal File.expand_path('~'), @instance.base_directory
  end

  def test_includes_fstest_assertions
    assert @klass.included_modules.include? FSTest::Assertions
  end

  def test_includes_file_utils
    assert @klass.included_modules.include? FileUtils
  end

  def test_assert_file
    File.open('/tmp/fstest', 'w') {|fh| fh.write("nom nom nom")}
    assert_file "/tmp/fstest", /^nom nom nom$/
    assert_file "/tmp/fstest", "nom nom nom"
  end

  def test_assert_not_file
    assert_no_file('/tmp/unknown')
  end

  def test_assert_directory
    FileUtils.mkdir_p('/tmp/fstest_dir')
    assert_directory '/tmp/fstest_dir'
  end

  def test_assert_no_directory
    assert_no_directory '/tmp/unknown_dir'
  end
end