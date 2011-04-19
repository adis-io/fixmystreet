class ReportsController < ApplicationController

  before_filter :check_auth, :only => [:new, :create, :edit, :update]
  before_filter :find_report, :only => [:show, :edit, :update,
    :destroy, :fixed]
  before_filter :check_perm, :only => [:edit, :update, :destroy,
    :fixed]

  def index
    @reports = Report.order("id desc").page params[:page]
  end

  def show
  end

  def new
    @report = Report.new
    @report.latitude = "42.861118"
    @report.longtitude = "74.607811"
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

  def edit
  end

  def update
    unless @report.update_attributes(params[:report])
      render :action => "edit" and return
    end
    redirect_to report_path @report
  end

  def destroy
    @report.delete
    flash[:notice] = t(:succesfully_deleted)
    redirect_to reports_path
  end

  def fixed
    @report.status = Report::FIXED
    @report.save
    flash[:notice] = t(:status_updated)
    redirect_to report_path @report and return
  end

  private
  def find_report
    @report = Report.find params[:id]
  end

  def check_perm
    authorize! :manage,  @report
  end

end
