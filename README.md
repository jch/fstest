# FSTest

Extracted file and directory assertion methods from
Rails::Generators::TestCase. Include the FSTest module for testing file
existence, and file contents.

## Installation

    gem install fstest

## Example

    class MyClassTest < MiniTest::Unit::TestCase
      include FSTest

      def test_writes_file
        assert_no_file '/tmp/foo'
        File.open('/tmp/foo', 'w') {|fh| fh.puts "nom nom"}
        assert_file '/tmp/foo', /^nom nom$/
      end
    end
