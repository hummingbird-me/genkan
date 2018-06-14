RSpec.describe GrantTypeConstraint do
  let(:request) do
    ActionDispatch::TestRequest.create('action_dispatch.request.request_parameters' => {
      grant_type: grant_type
    })
  end

  context 'with a string expectation' do
    subject { described_class.new('password') }

    context 'given an exact match' do
      let(:grant_type) { 'password' }
      it('should match') { expect(subject.matches?(request)).to be_truthy }
    end

    context 'given an exact match' do
      let(:grant_type) { 'not_password' }
      it('should not match') { expect(subject.matches?(request)).to be_falsy }
    end
  end

  context 'with a regex expectation' do
    subject { described_class.new(/\Aurn:ietf:params:oauth:/) }

    context 'given a value that matches the regex' do
      let(:grant_type) { 'urn:ietf:params:oauth:assertion:facebook' }
      it('should match') { expect(subject.matches?(request)).to be_truthy }
    end

    context 'given a value that does not match the regex' do
      let(:grant_type) { 'not_a_match' }
      it('should not match') { expect(subject.matches?(request)).to be_falsy }
    end
  end
end
