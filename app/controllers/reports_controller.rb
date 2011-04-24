class ReportsController < ApplicationController

  before_filter :set_locale
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
      flash[:error] = @report.errors.full_messages.to_sentence
      render :action => "new" and return
    end

    tweet_about @report
    facebook_about @report
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
      flash[:error] = @report.errors.full_messages.to_sentence
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

  def check_perm
    authorize! :manage,  @report
  end

  def tweet_about( report )
    if Rails.env.production?
      Twitter.configure do |config|
        config.consumer_key = SOCIAL_NETWORK_CONFIG["twitter"]["consumer_key"]
        config.consumer_secret = SOCIAL_NETWORK_CONFIG["twitter"]["consumer_secret"]
        config.oauth_token = SOCIAL_NETWORK_CONFIG["twitter"]["oauth_token"]
        config.oauth_token_secret = SOCIAL_NETWORK_CONFIG["twitter"]["oauth_token_secret"]
      end
      client = Twitter::Client.new
      text = "#{report_url(report)} #{report.title}"
      text = text[0...140]
      client.update text
    end
  rescue
  end

  def facebook_about(report)
    if Rails.env.production?
      client = HTTPClient.new
      rsp = client.post("https://graph.facebook.com/#{SOCIAL_NETWORK_CONFIG["facebook"]["page_id"]}/feed?access_token=#{URI.escape SOCIAL_NETWORK_CONFIG['facebook']['oauth_token']}",
          {:access_token => SOCIAL_NETWORK_CONFIG["facebook"]["oauth_token"],
           :link => report_url(report),
           :name => report.title
          }
        )
    end
  end

end
