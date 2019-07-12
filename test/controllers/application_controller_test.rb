require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get home with body' do
    get '/'

    assert_response :success
    assert_select 'h1', text: 'Image Sharer'
  end
end
