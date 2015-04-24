class InviteMailer < ApplicationMailer

  def invite_activation(invite)
    @greeting = "Hi"

    mail to: "bryan.knouse@gmail.com"
  end
end
