class CoimbraPortugalBitchingDriver < MailBitchingDriver

  def notify
    send_mail('Destino Coimbra', 'gustavo@felisberto.net')
  end

end