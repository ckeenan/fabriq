class NewsletterMailer < ApplicationMailer
  default from: "Newsletter@ourfabriq.com"

  def newsletter_activation(newsletter)
  	@newsletter = newsletter
    @greeting = "Hi"

    mail(to: "bryan.knouse@gmail.com", subject: 'Thanks for joining our newsletter!')
  end
end