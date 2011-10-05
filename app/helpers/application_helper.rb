module ApplicationHelper
  def render_reports_breadcrumb
    render :partial => 'shared/breadcrumbs',
      :locals => {:items => [[@country.name, root_path], @city.name]}
  end

  def render_report_breadcrumb
    render :partial => 'shared/breadcrumbs',
      :locals => {:items => [
        [ @country.name, root_path ],
        [ @city.name, list_reports_path(@city) ],
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
