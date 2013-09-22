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
  reports_to_expire = Report
  .where(created_at: {'$lte' => (Date.today - 16)}, closure_date: nil)
  .any_of(
      {last_reporter_confirmation: {'$lte' => (Date.today - 16)}},
      {last_reporter_confirmation: nil}
  )

  reports_to_expire.each do |report|
    report.mark_as_solved('rake_task')
    report.save
  end
end


desc 'Add missing fields to reports'
task :clean_old => :environment do
  reports_to_clean = Report.where({:closure_date.exists => false})

  reports_to_clean.each do |report|
    report.set(:closure_date, nil)
  end


  reports_to_clean = Report.where({:last_reporter_confirmation.exists => false})

  reports_to_clean.each do |report|
    report.set(:last_reporter_confirmation, nil)
  end


end


task :remark_old_auto_as_rake => :environment do
  reports_closed = Report.where(
      :closure_date.exists => true
  )

  reports_closed.each do |report|
    if (report.closure_date.hour == 9 and report.closure_date.minute == 0) or
        (report.closure_date.hour == 10 and report.closure_date.minute == 0)
      report.closure_type = 'rake_task'
    else
      report.closure_type = 'user'
    end
    report.save
  end

end
