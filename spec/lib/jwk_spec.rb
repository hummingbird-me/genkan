require 'rails_helper'
require 'jwk'

RSpec.describe JWK do
  context 'for an Elliptical Curve public key' do
    let(:key) do
      OpenSSL::PKey.read <<~PKEY
        -----BEGIN EC PARAMETERS-----
        BgUrgQQACg==
        -----END EC PARAMETERS-----
        -----BEGIN EC PRIVATE KEY-----
        MHQCAQEEIImYqc7p3m3wXat8ctO9IR9qoS34Q3UuIvhltkY4ay3FoAcGBSuBBAAK
        oUQDQgAEm1AYfCy4VR2jjeyhV29TNVbmyEj53seoV4PCofnSgUEOw6Saz3EOWR1N
        faL/Rzb90zhVpzEQz24DGO7GhfvWBA==
        -----END EC PRIVATE KEY-----
      PKEY
    end
    subject { described_class.new(key) }

    describe '#as_json' do
      it 'should return the coordinates of a key' do
        json = subject.as_json
        # These values were manually unpacked from OpenSSL
        expect(json['x']).to eq('m1AYfCy4VR2jjeyhV29TNVbmyEj53seoV4PCofnSgUE')
        expect(json['y']).to eq('DsOkms9xDlkdTX2i_0c2_dM4VacxEM9uAxjuxoX71gQ')
      end

      it 'should set the alg key to something starting with ES' do
        expect(subject.as_json['alg']).to start_with('ES')
      end

      it 'should set the kty key to EC' do
        expect(subject.as_json['kty']).to eq('EC')
      end

      it 'should set the crv key to the curve used' do
        expect(subject.as_json['crv']).to eq('P-256')
      end
    end
  end
end
