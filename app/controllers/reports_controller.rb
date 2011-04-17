class ReportsController < ApplicationController

  before_filter :check_auth, :only => [:new, :create]

  def index
    @reports = Report.page params[:page]
  end

  def show
    @report = Report.find params[:id]
  end

  def new
    @report = Report.new
    @report.latitude = "34"
    @report.longtitude = "74"
  end

  def create
    @report = Report.new
    @report.user = current_user
    @report.status = Report::NEW
    @report.update_attributes params[:report]
    unless @report.valid?
      render :action => "new" and return
    end
    redirect_to report_path @report
  end

  def about
  end

  def contacts
  end
end
