module MinimalJwt
  class InvalidPayloadError < StandardError
    attr_reader :message

    def initialize(message = '')
      super
      @message = message
    end
  end
end
