class ReportsController < ApplicationController
  before_filter :fetch_city, :only => [:show, :index, :edit, :update]
  before_filter :find_report, :only => [:show, :edit, :update, :destroy, :fixed]

  def index
    @reports = Report.located_in(@city).order("id desc").page params[:page]
  end

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new
    @report.user = current_user
    @report.status = Report::NEW
    @report.update_attributes params[:report]
    unless @report.valid?
      flash[:error] = @report.errors.full_messages.to_sentence
      render :action => "new" and return
    end

    redirect_to report_path @report.city, @report
  end

  def about
  end

  def contacts
  end

  def edit
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

  def fixed
    @report.status = Report::FIXED
    @report.save
    flash[:notice] = t(:status_updated)
    redirect_to report_path @report and return
  end

  def feed
    @new_reports = Report.where(:status => Report::NEW).order("id DESC").limit(10)
    @fixed_reports = Report.where(:status => Report::FIXED).order("id DESC").limit(10)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private
  def find_report
    @report = Report.find params[:id]
  end

  def fetch_city
    @city = City.find_by_slug(params[:city])
    render(:status => 404) and return if @city.nil?
  end
end
