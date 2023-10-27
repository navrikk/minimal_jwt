require 'spec_helper'

RSpec.describe Jwt do
  let(:token) { 'eyJhbGciOiJIUzI1NiJ9.eyJleHBpcmVzX2F0IjoiMjAyMy0xMC0yN1QxODo1NzozOS4wMDZaIiwicm9sZSI6InNlY3JldF9zZXJ2aWNlX2FnZW50IiwiaXNzdWVkX2F0IjoiMjAyMy0xMC0yN1QxODo1NzozOS4wMDZaIiwiaXNzdWVyIjoiYXV0aF9hZG1pbiIsInVzZXJuYW1lIjoiSmFtZXNCb25kMDA3In0.ZJwk1gHmdO9J9TjGIvFzWqRrgCNflVOILpd6AkkbtNg' }

  describe '#decode' do
    it 'returns the decoded payload' do
      actual = Jwt.decode(token)

      expect(actual).to eq({
                             expires_at: "2023-10-27T18:57:39.006Z",
                             role: "secret_service_agent",
                             issued_at: "2023-10-27T18:57:39.006Z",
                             issuer: "auth_admin",
                             username: "JamesBond007"
                           })
    end
  end
end
