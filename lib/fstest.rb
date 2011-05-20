module FSTest
  def self.included(base)
    base.class_eval {
      include InstanceMethods
      include Assertions
      include FileUtils
    }
  end

  module InstanceMethods
    def base_directory
      @base_directory
    end

    def base_directory=(path)
      @base_directory = File.expand_path(path)
    end
  end

  module Assertions
    # Asserts a given file exists. You need to supply an absolute path or a path relative
    # to the configured destination:
    #
    #   assert_file "config/environment.rb"
    #
    # You can also give extra arguments. If the argument is a regexp, it will check if the
    # regular expression matches the given file content. If it's a string, it compares the
    # file with the given string:
    #
    #   assert_file "config/environment.rb", /initialize/
    #
    # Finally, when a block is given, it yields the file content:
    #
    #   assert_file "app/controller/products_controller.rb" do |controller|
    #     assert_instance_method :index, content do |index|
    #       assert_match /Product\.all/, index
    #     end
    #   end
    #
    def assert_file(relative, *contents)
      absolute = File.expand_path(relative, base_directory)
      assert File.exists?(absolute), "Expected file #{relative.inspect} to exist, but does not"

      read = File.read(absolute) if block_given? || !contents.empty?
      yield read if block_given?

      contents.each do |content|
        case content
          when String
            assert_equal content, read
          when Regexp
            assert_match content, read
        end
      end
    end
    alias :assert_directory :assert_file

    # Asserts a given file does not exist. You need to supply an absolute path or a
    # path relative to the configured destination:
    #
    #   assert_no_file "config/random.rb"
    #
    def assert_no_file(relative)
      absolute = File.expand_path(relative, base_directory)
      assert !File.exists?(absolute), "Expected file #{relative.inspect} to not exist, but does"
    end
    alias :assert_no_directory :assert_no_file
  end
end