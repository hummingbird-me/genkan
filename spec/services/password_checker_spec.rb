# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordChecker do
  context 'with a valid password' do
    let!(:pass) { create(:user_password, user_id: '123', password: 'test') }

    describe '#password_valid?' do
      it 'should be true' do
        checker = PasswordChecker.new(pass.user_id)
        expect(checker.password_valid?('test'))
      end
    end

    describe '#validate_password!' do
      it 'should return true' do
        checker = PasswordChecker.new(pass.user_id)
        expect(checker.validate_password!('test'))
      end
    end
  end

  context 'with an invalid password' do
    let!(:pass) { create(:user_password, user_id: '123', password: 'test') }

    describe '#password_valid?' do
      it 'should be false' do
        checker = PasswordChecker.new(pass.user_id)
        expect(checker.password_valid?('invalid password')).to eq(false)
      end
    end

    describe '#validate_password!' do
      it 'should raise OAuth2Error::InvalidPassword' do
        checker = PasswordChecker.new(pass.user_id)
        expect {
          checker.validate_password!('invalid password')
        }.to raise_error(OAuth2Error::InvalidPassword)
      end
    end
  end
end
