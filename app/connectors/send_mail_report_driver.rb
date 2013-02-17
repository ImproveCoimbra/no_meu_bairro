class SendMailReportDriver < AbstractBitchingDriver
  def notify
    ReportMailer.report_email(@report).deliver
  end
end