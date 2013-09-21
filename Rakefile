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
      rescue;
      end

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
      report.mark_as_solved('rake_task')
      report.save
    end
  end


end


task :remark_old_auto_as_rake => :environment do
  reports_closed = Report.where(
      :closure_date.exists => true
  )



  reports_closed.each do |report|

    if report.closure_date.hour == 9 and report.closure_date.minute == 0
      report.closure_type = 'rake_task'
    else
      report.closure_type = 'user'
    end
    report.save
  end

end
