module ReportsHelper

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :pf => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'btn btn-small')
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

end
