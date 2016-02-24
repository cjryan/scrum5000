require 'test_helper'

class YamlDbBackupControllerTest < ActionController::TestCase
  test "should get render_yaml" do
    get :render_yaml
    assert_response :success
  end

end
