module LoginHelpers
  extend ActiveSupport::Concern

  # Generate a cookie to authenticate as a specific user ID
  #
  # @param user_id [String] the User ID to log in as
  # @return [String] the cookie string for the token
  def cookie_for(user_id)
    # Issue a token
    token = Token.create!(
      client: Client.first,
      user_id: user_id,
      expires_at: 6.months.from_now,
      scopes: %i[_all genkan]
    )
    # Generate the JWT
    token.to_jwt
  end

  # Login to Capybara
  #
  # @param user_id [String] the User ID to log in as
  # @return [void]
  def login_to_capybara_as(user_id)
    # Setting cookies won't work until we visit a page
    visit('/')
    # Generate the cookie and feed it into Headless Chrome via Selenium WebDriver via Capybara
    cookie = cookie_for(user_id)
    page.driver.browser.manage.add_cookie(
      name: 'token',
      value: cookie
    )
  end
end

RSpec.configure do |c|
  c.include LoginHelpers
end
