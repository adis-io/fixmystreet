class ReportsController < ApplicationController

  def index
    @reports = Report.all
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
    @report = Report.create params[:report]
    unless @report.valid?
      render :action => "new" and return
    end
    redirect_to report_path @report
  end
end
