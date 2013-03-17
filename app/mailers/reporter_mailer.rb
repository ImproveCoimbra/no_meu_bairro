# encoding: UTF-8
class ReporterMailer < ActionMailer::Base
  default from: "#{I18n.t(:app_name)} <bairro.app@gmail.com>"

  def reporter_email(report)
    @report = report
    name_and_mail_destination = "#{report.user.uuid}"
    mail(:to => name_and_mail_destination, :subject => "Problema (#{report.municipality.name}) - #{truncate(report.description, :length => 20)}")
  end
end
