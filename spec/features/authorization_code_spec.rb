# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OAuth2 Authorization Code Flow', type: :feature do
  let!(:client) do
    create(:client, redirect_uri: 'http://localhost:42069/')
  end
  let(:oauth) do
    OAuth2::Client.new(client.key, client.secret,
      site: 'http://localhost',
      redirect_uri: client.redirect_uri,
      authorize_url: '/authorize',
      token_url: '/token',
      connection_build: ->(builder) {
        builder.adapter :rack, Genkan::Application
      })
  end

  # Assuming the client is making a valid request, we need to test that everything works
  context 'approval of a valid request' do
    scenario 'when already logged in' do
      login_as 1

      visit oauth.authorize_url(response_type: 'code', client_id: client.key, scope: '_all')
      click_button('Allow')

      expect(page.current_url).to start_with('http://localhost:42069/')
      expect(page.current_url).to include('code=')
    end
  end

  context 'rejection of a valid request' do
    scenario 'when already logged in' do
      login_as 1

      visit oauth.authorize_url(response_type: 'code', client_id: client.key, scope: '_all')
      click_button('Deny')

      expect(page.current_url).to start_with('http://localhost:42069/')
      expect(page.current_url).to include('error=access_denied')
    end
  end
end
