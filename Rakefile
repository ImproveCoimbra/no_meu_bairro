#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Bitchingserver::Application.load_tasks


task :notify_ending => :environment do
  reports_to_expire = Report.where(
      closure_date: nil,
      last_reporter_confirmation: {'$lte' => (Date.today - 13)}
  )

  reports_to_expire.each { |report|

    if !report.user.nil? && !report.user.uuid.blank?
      begin
      NotifyReporterExpireMailer.expiring_email(report).deliver
      rescue;end

    end

  }

end

desc 'Find reports that have not been changed in a couple of weeks and close them'
task :expire_old => :environment do
  reports_to_expire = Report.where(
      closure_date: nil, 
      last_reporter_confirmation: {'$lte' => (Date.today - 16)}
  )

  reports_to_expire.each do |report|
    unless report.user.uuid.blank?
      report.mark_as_solved
      report.save
    end
  end


end
