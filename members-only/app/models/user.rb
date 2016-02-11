class User < ActiveRecord::Base
	before_create :remember
	has_secure_password

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def remember
			self.remember_digest = User.digest(User.new_token)
		end
end
