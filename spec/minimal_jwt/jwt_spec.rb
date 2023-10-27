require 'spec_helper'

RSpec.describe Jwt do
  describe '#decode' do
    context 'when a valid JWT is passed' do
      let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJleHBpcmVzX2F0IjoiMjAyMy0xMC0yN1QxODo1NzozOS4wMDZaIiwicm9sZSI6InNlY3JldF9zZXJ2aWNlX2FnZW50IiwiaXNzdWVkX2F0IjoiMjAyMy0xMC0yN1QxODo1NzozOS4wMDZaIiwiaXNzdWVyIjoiYXV0aF9hZG1pbiIsInVzZXJuYW1lIjoiSmFtZXNCb25kMDA3In0.ZJwk1gHmdO9J9TjGIvFzWqRrgCNflVOILpd6AkkbtNg' }

      it 'returns the decoded payload' do
        actual_payload = Jwt.decode(token)

        expected_payload = {
          expires_at: "2023-10-27T18:57:39.006Z",
          role: "secret_service_agent",
          issued_at: "2023-10-27T18:57:39.006Z",
          issuer: "auth_admin",
          username: "JamesBond007"
        }
        expect(actual_payload).to eq(expected_payload)
      end
    end

    context 'when an invalid JWT is passed' do
      let(:token) { 'header.payload.signature' }

      it 'raises an error' do
        expect {
          Jwt.decode(token)
        }.to raise_error(InvalidJwtError)
      end
    end
  end
end
