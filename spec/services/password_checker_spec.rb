require 'rails_helper'

RSpec.describe PasswordChecker do
  context 'with a valid username and password' do
    let!(:name) { create(:user_name, user_id: '123') }
    let!(:pass) { create(:user_password, user_id: '123', password: 'test') }

    describe '#password_valid?' do
      it 'should be true' do
        checker = PasswordChecker.new(name.name)
        expect(checker.password_valid?('test'))
      end
    end

    describe '#validate_password!' do
      it 'should return true' do
        checker = PasswordChecker.new(name.name)
        expect(checker.validate_password!('test'))
      end
    end
  end

  context 'with an invalid password' do
    let!(:name) { create(:user_name, user_id: '123') }
    let!(:pass) { create(:user_password, user_id: '123', password: 'test') }

    describe '#password_valid?' do
      it 'should be false' do
        checker = PasswordChecker.new(name.name)
        expect(checker.password_valid?('invalid password')).to eq(false)
      end
    end

    describe '#validate_password!' do
      it 'should raise OAuth2Error::InvalidPassword' do
        checker = PasswordChecker.new(name.name)
        expect {
          checker.validate_password!('invalid password')
        }.to raise_error(OAuth2Error::InvalidPassword)
      end
    end
  end

  context 'with an invalid username' do
    let!(:name) { create(:user_name, user_id: '123') }
    let!(:pass) { create(:user_password, user_id: '123', password: 'test') }

    describe '#password_valid?' do
      it 'should raise OAuth2Error::UserNotFound' do
        checker = PasswordChecker.new('Fake')
        expect {
          checker.password_valid?('test')
        }.to raise_error(OAuth2Error::UserNotFound)
      end
    end

    describe '#validate_password!' do
      it 'should raise OAuth2Error::UserNotFound' do
        checker = PasswordChecker.new('Fake')
        expect {
          checker.validate_password!('test')
        }.to raise_error(OAuth2Error::UserNotFound)
      end
    end
  end
end
