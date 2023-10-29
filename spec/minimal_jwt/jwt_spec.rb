require 'spec_helper'

RSpec.describe JWT do
  let(:payload) {
    {
      name: "John Doe",
      iat: 1516239022
    }
  }
  let(:token) { JWT.encode(payload: payload).token }
  let(:invalid_token) { 'header.payload.signature' }

  describe '#self.encode' do
    context 'when payload is valid' do
      it 'returns a JWT object' do
        actual = JWT.encode(payload: payload)

        expected = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBEb2UiLCJpYXQiOjE1MTYyMzkwMjJ9._Y13fWDqoWlKSW49j85a92gKfnxWpT6kmfdO8HYv-i4'
        expect(actual.token).to eq(expected)
      end
    end

    context 'when payload is invalid' do
      let(:payload) { 'not a hash' }

      it 'raises an InvalidPayloadError' do
        expect {
          JWT.encode(payload: payload)
        }.to raise_error(InvalidPayloadError)
      end
    end
  end

  describe '#valid?' do
    context 'when JWT valid' do
      it 'returns true' do
        expect(JWT.new(token: token).valid?).to be_truthy
      end
    end

    context 'when JWT is invalid' do
      it 'returns false' do
        expect(JWT.new(token: invalid_token).valid?).to be_falsey
      end
    end
  end

  describe '#header' do
    context 'when JWT is valid' do
      it 'returns the header' do
        actual = JWT.new(token: token).header

        expect(actual).to eq({
                               'alg' => 'HS256',
                               'typ' => 'JWT'
                             })
      end
    end

    context 'when JWT is invalid' do
      it 'raises an InvalidJwtError' do
        expect {
          JWT.new(token: invalid_token).header
        }.to raise_error(InvalidJwtError)
      end
    end
  end

  describe '#payload' do
    context 'when JWT is valid' do
      it 'returns the payload' do
        actual = JWT.new(token: token).payload

        expect(actual.transform_keys(&:to_sym)).to eq(payload)
      end
    end

    context 'when JWT is invalid' do
      it 'raises an InvalidJwtError' do
        expect {
          JWT.new(token: invalid_token).payload
        }.to raise_error(InvalidJwtError)
      end
    end
  end

  describe '#signature_verified?' do
    context 'when signature can be verified' do
      it 'returns true' do
        expect(JWT.new(token: token).signature_verified?).to be_truthy
      end
    end

    context 'when signature cannot be verified' do
      let(:token) { 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBEb2UiLCJpYXQiOjE1MTYyMzkwMjJ9.G5yRiQhJFBOvsfJV1Vm0T1VPtOyxsff-QAKjmdfJcds' }

      it 'returns false' do
        jwt = JWT.new(token: token)

        expect(jwt.signature_verified?).to be_falsey
        expect(jwt.header).to eq({
                                   'alg' => 'HS256',
                                   'typ' => 'JWT'
                                 })
        expect(jwt.payload.transform_keys(&:to_sym)).to eq(payload)
      end
    end
  end
end
