# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPassword do
  it { should define_enum_for(:status) }
  it { should define_enum_for(:source) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:password) }

  describe 'password field' do
    it 'should hash the password when setting' do
      pass = UserPassword.new
      expect(pass.password).to be_nil
      pass.password = 'test'
      # Check for the BCrypt prefix
      expect(pass.attributes['password']).to start_with('$2a$')
    end

    it 'should return a BCrypt::Password when getting' do
      pass = UserPassword.new(password: 'test')
      expect(pass.password).to be_a(BCrypt::Password)
    end
  end
end
