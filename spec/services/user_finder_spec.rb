require 'rails_helper'

RSpec.describe UserFinder do
  context 'with a known name' do
    let!(:name) { create(:user_name, user_id: '123') }

    describe '#user_id' do
      it 'should return the User ID' do
        finder = UserFinder.new(name.name)
        expect(finder.user_id).to eq(name.user_id)
      end
    end

    describe '#user_id!' do
      it 'should return the User ID' do
        finder = UserFinder.new(name.name)
        expect(finder.user_id!).to eq(name.user_id)
      end
    end
  end

  context 'with an unknown name' do
    let!(:name) { create(:user_name, user_id: '123', name: 'RealName') }

    describe '#user_id' do
      it 'should be nil' do
        finder = UserFinder.new('ThisIsAFakeName')
        expect(finder.user_id).to be_nil
      end
    end

    describe '#user_id!' do
      it 'should raise OAuth2Error::UserNotFound' do
        finder = UserFinder.new('ThisIsAFakeName')
        expect {
          finder.user_id!
        }.to raise_error(OAuth2Error::UserNotFound)
      end
    end
  end
end
