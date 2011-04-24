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
end
