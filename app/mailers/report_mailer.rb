# encoding: UTF-8
class ReportMailer < ActionMailer::Base
  default from: "No Bairro <bairro.app@gmail.com>"

  def report_email(report)
    @report = report
    name_and_mail_destination = "#{report.municipality.driver_parameters["destination_name"]} <#{report.municipality.driver_parameters["destination_mail"]}>"
    mail(:to => name_and_mail_destination, :subject => "Situação Reportada em #{report.municipality.name} - #{report.id}")
  end
end
