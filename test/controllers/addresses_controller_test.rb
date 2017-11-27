require 'test_helper'

class AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get autocomplete" do
    get addresses_autocomplete_url(term: 'Kladno 677')
    assert_response :success
  end

  test "should get address" do
    get show_address_url(id: 1385976)
    assert_response :success
  end

end
