class ReportsController < ApplicationController
  load_and_authorize_resource
  before_filter :fetch_city, except: [:new, :create]
  before_filter :fetch_reports,
    only: [:index, :fixed, :waiting_moderation, :waiting_confirmation, :inactive]

  def index
    @reports_type = :active_reports
    @reports = @reports.active.page params[:page]
  end

  def fixed
    @reports = @reports.fixed.page params[:page]
    render 'index'
  end

  def waiting_moderation
    @reports = @reports.where(:user_id => current_user) unless can? :manage, Report
    @reports = @reports.waiting_moderation.page params[:page]
    render 'index'
  end

  def waiting_confirmation
    @reports = @reports.where(:user_id => current_user) unless can? :manage, Report
    @reports = @reports.waiting_confirmation.page params[:page]
    render 'index'
  end

  def inactive
    @reports = @reports.where(:user_id => current_user) unless can? :manage, Report
    @reports = @reports.inactive.page params[:page]
    render 'index'
  end

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(params[:report])
    unless @report.save
      flash[:error] = @report.errors.full_messages.to_sentence
      render :action => "new" and return
    end

    redirect_to report_path @report.city, @report
  end

  def update
    @report.city = @city
    unless @report.update_attributes(params[:report])
      flash[:error] = @report.errors.full_messages.to_sentence
      render :action => "edit" and return
    end
    redirect_to report_path @report.city, @report
  end

  def destroy
    city = @report.city
    @report.delete
    flash[:notice] = t(:succesfully_deleted)
    redirect_to list_reports_path city
  end

  def accept
    @report.accept!
    redirect_to report_path @city, @report
  end

  def request_fixed
    @report.request_fixed!
    @report.confirm_fixed! if can? :manage, Report
    redirect_to report_path @city, @report
  end

  def confirm_fixed
    @report.confirm_fixed!
    redirect_to report_path @city, @report
  end

  def decline_fixed
    @report.decline_fixed!
    redirect_to report_path @city, @report
  end

  def activate
    @report.activate!
    redirect_to report_path @city, @report
  end

  def inactivate
    @report.inactivate!
    redirect_to report_path @city, @report
  end

  def feed
    @new_reports = Report.where(:status => Report::NEW).order("id DESC").limit(10)
    @fixed_reports = Report.where(:status => Report::FIXED).order("id DESC").limit(10)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private
  def fetch_reports
    @reports_type = "#{action_name}_reports".to_sym
    @reports = @reports.located_in(@city).order("id desc").scoped
  end

  def fetch_city
    @city = City.find_by_slug(params[:city])
    render(:status => 404) and return if @city.nil?
  end
end
