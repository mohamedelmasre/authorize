require 'rubygems'
require 'active_support'
require 'test/unit'
require 'mocha'

require File.join(File.dirname(__FILE__), '../lib/authorize')

class Test::Unit::TestCase
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
    defined   = instance_method(test_name) rescue false
    
    raise "#{test_name} is already defined in #{self}" if defined
    
    define_method(test_name, &block)
  end
  
  def self.setup(&block)
    define_method(:setup, &block)
  end
end

class User
  def self.named_scope(*args)
    # mock named_scope definition
    eval "def User.#{args.first}; end"
  end
  
  def self.authors
    'list of authors'
  end
  
  include Authorize::Roles
  
  attr_accessor :role
  
  def initialize(options = {})
    @role = options[:role]
  end
end