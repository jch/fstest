# FSTest

Blatantly stolen file and directory assertion methods from
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

## Overview

I couldn't find any good examples of tests for [Rails
generators](http://guides.rubyonrails.org/generators.html), so I looked at the
Rails tests. Rails uses a custom test class called
Rails::Generators::TestCase. This class has methods for testing the output of
generators. I thought the methods would be useful outside of a Rails context,
so I wrapped it up in the FSTest gem. Enjoy!

## Extras

If you want to work with relative paths instead of absolute paths, you can
set the 'base\_directory' in a setup block.

    class MyClassTest < MiniTest::Unit::TestCase
      include FSTest

      def setup
        # all assert_file assertions will be relative to your homedir
        self.base_directory = File.expand_path("~")
      end

      def test_dot_emacs
        # this will look for ~/.emacs
        assert_file '.emacs'
      end
    end

I've also found it useful to use [FakeFS](https://github.com/defunkt/fakefs)
alongside this.