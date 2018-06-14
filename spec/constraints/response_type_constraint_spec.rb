RSpec.describe ResponseTypeConstraint do
  let(:request) do
    ActionDispatch::TestRequest.create('action_dispatch.request.query_parameters' => {
      response_type: response_type
    })
  end

  context 'with a string expectation' do
    subject { described_class.new('code') }

    context 'given an exact match' do
      let(:response_type) { 'code' }
      it('should match') { expect(subject.matches?(request)).to be_truthy }
    end

    context 'given an exact match' do
      let(:response_type) { 'not_code' }
      it('should not match') { expect(subject.matches?(request)).to be_falsy }
    end
  end

  context 'with a regex expectation' do
    subject { described_class.new(/\Aurn:ietf:params:oauth:/) }

    context 'given a value that matches the regex' do
      let(:response_type) { 'urn:ietf:params:oauth:assertion:facebook' }
      it('should match') { expect(subject.matches?(request)).to be_truthy }
    end

    context 'given a value that does not match the regex' do
      let(:response_type) { 'not_a_match' }
      it('should not match') { expect(subject.matches?(request)).to be_falsy }
    end
  end
end
