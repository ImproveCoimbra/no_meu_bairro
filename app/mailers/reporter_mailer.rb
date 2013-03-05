# encoding: UTF-8
class ReporterMailer < ActionMailer::Base
  default from: "No Bairro <bairro.app@gmail.com>"

  def reporter_email(report)
    @report = report
    name_and_mail_destination = "#{report.user.uuid}"
    mail(:to => name_and_mail_destination, :subject => "Editar Situação Reportada em #{report.municipality.name} - #{report.id}")
  end
end
