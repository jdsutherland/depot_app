require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    assert_template 'store/index'

    assert_select 'title', full_title('Catalog')

    # TODO: add links
    # assert_select 'a[href=?]', root_path
    # assert_select 'a[href=?]', help_path
    # assert_select 'a[href=?]', about_path
    # assert_select 'a[href=?]', contact_path
    # get contact_path
    # assert_select 'title', full_title('Contact')
    # get signup_path
    # assert_select 'title', full_title('Sign up')
  end
end
