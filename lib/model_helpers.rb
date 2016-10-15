require 'securerandom'

module ModelHelpers
  def self.generate_uuid
    SecureRandom.uuid
  end
end