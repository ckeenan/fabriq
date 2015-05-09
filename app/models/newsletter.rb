class Newsletter < ActiveRecord::Base
	attr_accessible :email
	before_save :downcase_email


	def send_newsletter_email
		NewsletterMailer.newsletter_activation(self).deliver_now
	end

	private

		def downcase_email
			self.email = email.downcase
		end
end
