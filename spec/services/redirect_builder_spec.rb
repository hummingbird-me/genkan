require 'rails_helper'

RSpec.describe RedirectBuilder do
  context 'with a custom URI scheme' do
    context 'and no existing fragment data' do
      subject { RedirectBuilder.new('myapp://callback', :fragment) }

      it 'should not damage the URL scheme' do
        expect(subject.uri_for(test: 'foo')).to start_with('myapp://')
      end

      it 'should serialize the data into a fragment' do
        expect(subject.uri_for(test: 'foo')).to end_with('test=foo')
      end
    end

    context 'with existing query fragment data' do
      subject { RedirectBuilder.new('myapp://callback#existing=fragment', :fragment) }

      it 'should maintain existing fragment query fields' do
        expect(subject.uri_for(test: 'foo')).to end_with('#existing=fragment&test=foo')
      end
    end

    context 'with existing non-query fragment data' do
      subject { RedirectBuilder.new('myapp://callback#existing', :fragment) }

      it 'should be placed before the inserted query fragment data' do
        expect(subject.uri_for(test: 'foo')).to end_with('#existing&test=foo')
      end
    end
  end

  context 'with an HTTPS URL' do
    context 'with no existing query parameters' do
      subject { RedirectBuilder.new('https://example.com/callback', :query) }

      it 'should serialize the data into the query parameters' do
        expect(subject.uri_for(test: 'foo')).to end_with('?test=foo')
      end
    end

    context 'with existing query parameters' do
      subject { RedirectBuilder.new('https://example.com/callback?nonce=test', :query) }

      it 'should serialize the data into the query parameters' do
        expect(subject.uri_for(test: 'foo')).to end_with('?nonce=test&test=foo')
      end
    end
  end
end
