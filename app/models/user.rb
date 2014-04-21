class User < ActiveRecord::Base
  validates_presence_of :email, :first_name, :last_name, :identifier
  validates_uniqueness_of :email

  def self.build_identifier email
    if email.present?
      stripped = email.downcase.strip
      hash = Digest::MD5.hexdigest("#{Rails.application.secrets.client_identifier}|#{stripped}")
    else
      hash = SecureRandom.hex(16)
    end
    "1_#{hash}"
  end
end
