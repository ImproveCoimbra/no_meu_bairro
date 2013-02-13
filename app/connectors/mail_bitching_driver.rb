class MailBitchingDriver < AbstractBitchingDriver
  require 'net/smtp'

  APP_NAME = 'Bitching Server'
  APP_MAIL = 'humpback@gmail.com'
  APP_GMAIL_SMTP_PASS = 'you wanted this password right?'

  def send_mail(destination_name, destination_mail)
    #TODO fix issue with having non ASCII chars in message
    message = <<MESSAGE_END
From: #{APP_NAME} <#{APP_MAIL}>
To: #{destination_name} <#{destination_mail}>
MIME-Version: 1.0
Content-type: text/html
Subject: Notificacao de Problema

#{get_message}

<b>This is HTML message.</b>
<h1>This is headline.</h1>
MESSAGE_END

    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    smtp.start('gmail.com', APP_MAIL, APP_GMAIL_SMTP_PASS, :login)
    smtp.send_message message, APP_MAIL, destination_mail
    smtp.finish
  end


end