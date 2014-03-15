module ReportsHelper

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :pf => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'btn btn-small')
  end

  def reports_stats(reports)
    stats = {}
    stats[:total] = reports.size
    stats[:open] = reports.count{|report| report.closure_date.nil?}
    stats[:fixed] = reports.count{|report| report.closure_type == 'user'}
    stats[:uncertain] = reports.count{|report| !report.closure_date.nil? and report.closure_type != 'user'}
    if stats[:fixed] > 0
      stats[:time_to_fix] = (
        reports.select do |report|
          report.closure_type == 'user'
        end.map do |report|
          (report.closure_date - report.created_at.to_datetime).to_i
        end.sum.to_f / stats[:fixed]
      ).round
    end
    stats
  end

  def group_reports_by_month(reports)
    months = ActiveSupport::OrderedHash.new
    reports.each do |report|
      key = report.created_at.strftime "%m/%Y"
      months[key] ||= []
      months[key] << report
    end
    months
  end

  def display_percentage(value, total)
    "#{(value.to_f / total * 100).round(1)}% (#{value})"
  end

end
