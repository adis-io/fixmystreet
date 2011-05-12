module ReportsHelper

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
#    elsif url =~ /bulbul\.kg/
#      video_id = url.match(/video:(\d+)\//)
#      if video_id
#        video_id = video_id[1]
#        return <<EOT
#          <object width="#{width}" height="#{height}" name="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="player">
#            <param value="http://www.bulbul.kg/player/flvplayer.swf" name="movie">
#            <param value="true" name="allowfullscreen">
#            <param value="always" name="allowscriptaccess">
#            <param value="file=http://static.bulbul.kg/flv/#{video_id[-1]}/#{video_id}.flv&image=http://static.bulbul.kg/img/#{video_id[-1]}/#{video_id}.jpg&logo=http://bulbul.kg/css/images/minilogo3.png" name="flashvars">
#            <embed width="#{width}" height="#{height}" flashvars="file=http://static.bulbul.kg/flv/#{video_id[-1]}/#{video_id}.flv&image=http://static.bulbul.kg/img/#{video_id[-1]}/#{video_id}.jpg&logo=http://bulbul.kg/css/images/minilogo3.png" allowfullscreen="true" allowscriptaccess="always" src="http://www.bulbul.kg/player/flvplayer.swf" name="player2" id="player2" type="application/x-shockwave-flash">
#          </object>
#EOT
#      end
#    end
#  end

