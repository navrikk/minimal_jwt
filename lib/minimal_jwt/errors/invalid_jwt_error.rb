class InvalidJwtError < StandardError
  attr_reader :message

  def initialize(message = '')
    super
    @message = message
  end
end
