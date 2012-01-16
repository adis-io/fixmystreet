module ReportsHelper

  def display_waiting_moderation_item?
    current_user.present? and \
      (current_user.admin? or current_user.moderator? or \
       current_user.reports.waiting_moderation.count > 0)
  end

  def embed_tag video_url, options = {}
    return nil if video_url.nil? or video_url.empty?
    width = if params[:width] then params[:width] else 240 end
    height = if params[:height] then params[:height] else 195 end
    video_id, video_provider = parse video_url
    return nil unless video_provider
    # find out video hosting

    render :template => "ca_embed/_#{video_provider}",
      :locals => {:video_id => video_id, :width => width, :height => height}
  rescue ActionView::MissingTemplate
  end

  private

  def parse url
    if url =~ /youtube\.com/
      video_id = CGI.parse(URI.parse(url).query)['watch?v'][0]
      if video_id =~ /^[A-Za-z\d]+$/
        return [video_id, 'youtube']
      end
    elsif url =~ /blive\.kg/
      video_id = url.match(/video:(\d+)\//)
      if video_id
        video_id = video_id[1]
        return [video_id, 'blive']
      end
    end
  end
end
