xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Fixmystreet Kyrgyzstan"
    xml.description "Fixmystreet Kyrgyzstan Feed"
    xml.link reports_path
    for report in @new_reports
      xml.item do
        xml.title report.title
        xml.description report.description
        xml.pubDate report.created_at.to_s(:rfc822)
        xml.link report_path(report)
        xml.guid "new-#{report.id}"
      end
    end

    for report in @fixed_reports
      xml.item do
        xml.title report.title
        xml.description report.description
        xml.pubDate report.created_at.to_s(:rfc822)
        xml.link report_path(report)
        xml.guid "fixed-#{report.id}"
      end
    end

  end
end
