var FixMyStreet = function() {}

FixMyStreet.render_report_map = function(report) {
  var report = report['report'];
  _.extend(report, {zoom: 15});
  var map = FixMyStreet.render_map(report);
  FixMyStreet.put_marker({
    map: map,
    lat: report.lat,
    lng: report.lng,
  });
}

FixMyStreet.render_edit_report_map = function(cities, report) {
  if (report.lat && report.lng) {
    var entity = report['report'];
    _.extend(entity, {zoom: 15});
  } else {
    var entity = cities[0]['city'];
  }
  var map = FixMyStreet.render_map(entity);
  var marker = new google.maps.Marker({map: map});

  $('#report_city_id').change(function() {
    var city = eval($('option:selected', this).data('params'))['city'];
    var ll = new google.maps.LatLng(city.lat, city.lng);
    map.setZoom(city.zoom);
    map.setCenter(ll);
  });

  google.maps.event.addListener(map, 'click', function(event) {
    var location = event.latLng;
    marker.setPosition(location);
    $("#report_lat").val(location.lat());
    $("#report_lng").val(location.lng());
  });

}

FixMyStreet.render_country_map = function(country, cities) {
  // render map
  var map = FixMyStreet.render_map(country['country']);

  // put city markers
  _.each(cities, function(city) {
    var city = city["city"];
    FixMyStreet.put_marker({
      map:           map,
      lat:           city.lat,
      lng:           city.lng,
      label_text:    city.name,
      label_class:   "labels",
      click_handler: function() {
        window.location.href = '/'+ city.slug +'/reports';
      }
    });
  });
}

FixMyStreet.render_city_map = function(city, reports) {
  // render map
  var map = FixMyStreet.render_map(city['city']);

  // render markers
  _.each(reports, function(report) {
    var report = report['report'];
    FixMyStreet.put_marker({
      map:         map,
      lat:         report.lat,
      lng:         report.lng
    });
  });
}

FixMyStreet.render_map = function(map_credentials) {
  var myLatlng = new google.maps.LatLng(map_credentials.lat,map_credentials.lng);
  var myOptions = {
      zoom: map_credentials.zoom,
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  return new google.maps.Map(document.getElementById("map_canvas"), myOptions);
}

FixMyStreet.put_marker = function(opts) {
  var ll = new google.maps.LatLng(opts.lat, opts.lng);
  var marker = new MarkerWithLabel({
    position: ll,
    labelContent: opts.label_text,
    labelStyle: {opacity: 1},
    labelClass: opts.label_class,
    labelAnchor: new google.maps.Point(0, 0),
    map: opts.map
  });
  google.maps.event.addListener(marker, 'click', opts.click_handler);
}
