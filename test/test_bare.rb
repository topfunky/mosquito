require File.dirname(__FILE__) + "/switcher"
require File.dirname(__FILE__) + "/../lib/mosquito"
require File.dirname(__FILE__) + "/../public/bare"

# When you got a few Camping apps in one process you actually install the session
# for all of them simply by including. We want to test operation without sessions so we
# call this app Bare, which comes before Blog.
class TestBare < Camping::FunctionalTest

  test "should get index with success" do
    get '/'
    assert_response :success
    assert_no_session
    assert_match_body %r!Charles!
  end

  def test_get_without_arguments_should_give_us_the_index_page
    get
    assert_response :success
    assert_match_body %r!Charles!
  end

  test "should get sample page with success" do
    get '/sample'
    assert_response :success
    assert_no_session
    assert_match_body %r!<p>A sample page</p>!
  end

  test "should place the passed query params in the querystring" do
    get '/sample', :somevar => 10
    assert_equal '/bare/sample?somevar=10', @request['REQUEST_URI']
  end

  test "should assert_no_match_body" do
    get '/sample'
    assert_no_match_body /Rubber\s+Bubblegum\s+Burt Reynolds\s+Hippopotamus/
  end

  test "should return error" do
    if Camping.respond_to?(:call)
      # Camping on Rack reraises the errors which are caught by Rack's exception displayer
      assert_raise(RuntimeError) { get '/error' }
    else
      assert_nothing_raised { get '/error' }
      assert_response :error
    end
  end

  test "should return 404 error" do
    get '/error404'
    assert_response 404
  end
  
  test "should be able to assign verbatim POST payload" do
    post '/sample', 'foo=bar&plain=flat'
    @request.body.rewind
    assert_equal 'foo=bar&plain=flat', @request.body.read
    assert_equal( {"foo"=>"bar", "plain"=>"flat"}, @assigns.input)
  end
  
  test "should redirect" do
    get '/redirect'
    assert_redirected_to '/faq'
  end

  test "should coerce Mab in response to a String" do
    assert_nothing_raised { get '/non-existing-something-something' }
    assert_nothing_raised do
      assert_kind_of String,  @response.body
    end
  end

  # test "should send file" do
  #   get '/file'
  #   assert_response :success
  #   # TODO
  # end

end
