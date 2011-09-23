FixMyStreet.Reports = function() {}
FixMyStreet.Reports.Index = function() {
  this.render_map = function() {
    var myLatlng = new google.maps.LatLng(
        FixMyStreet.city.,<%= @city.long %>);
    var myOptions = {
        zoom: <%= @city.zoom %>,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    <% @reports.each do |report| %>
      var myLatLng = new google.maps.LatLng(<%= report.latitude %>, <%= report.longtitude %>);
      var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          <%= "icon:'/images/green-marker.png'," if report.fixed? %>
          title: "<%= report.title %>"
      });
      google.maps.event.addListener(marker, 'click', function() {
        window.location.href = '<%= report_path @city, report %>';
      });
    <% end %>
  }
}
