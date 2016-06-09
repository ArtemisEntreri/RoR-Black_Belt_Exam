class User < ActiveRecord::Base
	has_many :organizations
	has_many :plans
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :first_name, :last_name, presence: :true, length: { within: 2..20 }
	validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }


	def has_password?(submitted_password)
		self.password == submitted_password
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
end
