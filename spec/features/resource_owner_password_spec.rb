# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OAuth2 Resource Owner Password Flow', js: true, type: :feature do
  let!(:client) { create(:client) }

  context 'with a valid username and password' do
    let!(:name) { create(:user_name, user_id: '123') }
    let!(:pass) { create(:user_password, user_id: '123', password: 'test') }

    it 'should give us a token' do
      oauth = OAuth2::Client.new(client.key, client.secret,
        site: "http://#{capybara_host}",
        authorize_url: '/authorize',
        token_url: '/token')
      token = oauth.password.get_token(name.name, 'test', scope: 'profile.read')
      expect(token).to be_a(OAuth2::AccessToken)
    end
  end

  context 'with an invalid username and password' do
    let!(:name) { create(:user_name, user_id: '123') }
    let!(:pass) { create(:user_password, user_id: '123', password: 'the password') }

    it 'should give an OAuth2 Error' do
      oauth = OAuth2::Client.new(client.key, client.secret,
        site: "http://#{capybara_host}",
        authorize_url: '/authorize',
        token_url: '/token')
      expect {
        oauth.password.get_token(name.name, 'not the password', scope: 'profile.read')
      }.to raise_error(OAuth2::Error, /invalid_grant.*password did not match/i)
    end
  end
end
