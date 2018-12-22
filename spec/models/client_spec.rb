# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#valid_secret?' do
    let(:client) { Client.new(secret: 'naruto') }

    it 'should return true when given the correct secret' do
      expect(client.valid_secret?('naruto')).to be_truthy
    end
    it 'should return false when given the wrong secret' do
      expect(client.valid_secret?('boruto')).to be_falsy
    end
  end

  describe '#permitted_scopes' do
    it 'should provide some public scopes by default' do
      client = Client.new
      expect(client.permitted_scopes).to include('openid')
    end
    it 'should not include the child-token permission by default' do
      client = Client.new
      expect(client.permitted_scopes).not_to include('_children')
    end

    context 'for a client with child-token permissions' do
      let(:client) { Client.new(children: true) }
      it 'should have the _children magic scope' do
        expect(client.permitted_scopes).to include('_children')
      end
    end
  end
end
