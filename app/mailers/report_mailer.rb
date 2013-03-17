# encoding: UTF-8
class ReportMailer < ActionMailer::Base
  default from: "#{I18n.t(:app_name)} <bairro.app@gmail.com>"

  def report_email(report)
    @report = report
    name_and_mail_destination = "#{report.municipality.driver_parameters["destination_name"]} <#{report.municipality.driver_parameters["destination_mail"]}>"
    mail(:to => name_and_mail_destination, :subject => "Problema (#{report.municipality.name}) - #{truncate(report.description)}")
  end

  def truncate(text)
    text[0..17] + (text.size > 17 ? '...' : '')
  end

end
