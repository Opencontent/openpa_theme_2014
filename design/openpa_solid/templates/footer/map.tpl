{if $pagedata.contacts.indirizzo}
<div id="footer-map" style="height:300px"></div>
<script type="text/javascript">
    var query = "{$pagedata.contacts.indirizzo}";
    var latitudine = "{$pagedata.contacts.latitudine}";
    var longitudine = "{$pagedata.contacts.longitudine}";
{literal}
    var footerMap = new L.Map('footer-map');
    footerMap.scrollWheelZoom.disable();
    var footerMarkers = L.featureGroup();
    L.tileLayer('//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a>'
    }).addTo(footerMap);
    if (latitudine != '' && longitudine != '') {
      $('#footer-map-container').show();
      var latLng = new L.latLng(latitudine, longitudine);
      var customIcon = L.MakiMarkers.icon({icon: "star", color: "#000", size: "l"});
      var marker = new L.marker(latLng, {icon: customIcon, draggable: true});
      marker.addTo(footerMap);
      footerMarkers.addLayer(marker);
      footerMap.setView(latLng, 16 );
    }else{
      var control = new L.Control.Geocoder({geocoder: null});
      if (window.XDomainRequest)
          control.options.geocoder = L.Control.Geocoder.bing('Ahmnz1XxcrJXgiVWzx6W8ewWeqLGztZRIB1hysjaoHI5nV38WXxywjh6vj0lyl4u');
      else
          control.options.geocoder = L.Control.Geocoder.google('AIzaSyDVnxoH2lLysFsPPQcwxZ0ROYNVCBkmQZk');
      control.options.geocoder.geocode(query, function (result) {
          if ( result.length > 0 ) {
              $('#footer-map-container').show();
              var latLng = new L.latLng(result[0].center.lat, result[0].center.lng);
              var customIcon = L.MakiMarkers.icon({icon: "star", color: "#000", size: "l"});
              var marker = new L.marker(latLng, {icon: customIcon, draggable: true});
              marker.addTo(footerMap);
              footerMarkers.addLayer(marker);
              footerMap.setView(latLng, 16 );
          }else{
              console.log("Nessun risultato per " + query);
          }
      }, this);
    }
{/literal}
</script>
{/if}
