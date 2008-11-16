require File.dirname(__FILE__) + "/switcher"
require File.dirname(__FILE__) + '/test_helpers'
require File.dirname(__FILE__) + '/../public/blog'

Blog.create
include Blog::Models

class SomeTest < Camping::Test
  fixtures :blog_posts
  def setup
    super
    @parent_done = true
  end
  
  def test_setup_has_ran
    assert_not_nil @parent_done, "This variable is set in setup"
  end
end

module FixtureReloadingTests
  def test_fixtures_reloaded_after_run_say_a
    assert_equal 2, Post.count, "The test should start with 2 preloaded Posts"
    Post.delete_all
  end

  def test_fixtures_reloaded_after_run_say_b
    assert_equal 2, Post.count, "The test should start with 2 preloaded Posts"
    Post.delete_all
  end
end

class Sec < SomeTest; end
class Third < SomeTest; end
class Fourth < SomeTest
  include FixtureReloadingTests
end

# This exploits something that Rails considers an edge case but what is essential for us
# - inheriting test cases with setup that also use fixtures
class FixturedTest < Camping::WebTest
  def setup
    super
    @setup_in_parent = true
  end
end

class InheritedFixturedTest < FixturedTest
  fixtures :blog_posts
  def setup
    super
    @setup_in_child = true
  end
end

class ThirdInheritedFixturedTest < InheritedFixturedTest
  def setup
    super
    @setup_in_third = true
  end
  include FixtureReloadingTests
end

class FourthInherited < ThirdInheritedFixturedTest
  include FixtureReloadingTests
  
  def test_case_setup_properly
    assert_not_nil @request, "The setup for Mosquito web test should have been done"
    assert_not_nil @setup_in_parent, "The first setup in the chain should have happened"
    assert_not_nil @setup_in_child, "The second setup in the chain should have happsened"
    assert_not_nil @setup_in_third, "The third setup in the chain should have happened"
  end
end