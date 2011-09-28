module ApplicationHelper
  def display_flash
    flash_types = [:error, :warning, :notice]

    messages = ((flash_types & flash.keys).collect do |key|
      "$.jGrowl('#{flash[key].gsub(/'/, "\\\\'")}', { header: '#{I18n.t(key, :default => key.to_s)}', theme: '#{key.to_s}'});"
    end.join("\n"))

    if messages.size > 0
      content_tag(:script, :type => "text/javascript") do
        "$(document).ready(function() { #{messages} });"
      end
    else
      ""
    end
  end

  def render_reports_breadcrumb
    render :partial => 'shared/breadcrumbs',
      :locals => {:items => [[@country.name, root_path], @city.name]}
  end

  def render_report_breadcrumb
    render :partial => 'shared/breadcrumbs',
      :locals => {:items => [
        [@country.name, root_path],
        [@city.name, list_reports_path(@city)],
        @report.title]}
  end

  def render_report_new_edit_breadcrumb
    items = [[@country.name, root_path]]
    if @report.new_record?
      items << t(:new_report)
    else
      items << [@report.city.name, list_reports_path(@report.city)]
      items << "#{t(:edit)} #{@report.title}"
    end
    render :partial => 'shared/breadcrumbs',
      :locals => {:items => items}
  end

  def new_edit_form_path
    if @report.new_record?
      reports_path
    else
      report_path(@report.city, @report)
    end
  end
end
