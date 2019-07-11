require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get '/'
    assert_response :success
  end

  test 'should get home with body' do
    get '/'
    assert_not_equal @response.body, nil, 'response did not have a body'
  end
end
