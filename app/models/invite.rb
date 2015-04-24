class Invite < ActiveRecord::Base
	attr_accessible :email
	before_save :downcase_email


	def send_invite_email
		InviteMailer.invite_activation(self).deliver_now
	end

	private

		def downcase_email
			self.email = email.downcase
		end
end
