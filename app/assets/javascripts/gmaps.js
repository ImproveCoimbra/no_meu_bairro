function initialize_map(elementId, latitude, longitude) {

    var location = new google.maps.LatLng(latitude, longitude);

    var mapOptions = {
        center: location,
        zoom: 17,
        mapTypeId: google.maps.MapTypeId.HYBRID
    };
    var map = new google.maps.Map(document.getElementById(elementId),
        mapOptions);


    var markerOptions = {
        map: map,
        position: location,
        raiseOnDrag: false,
        visible: true
    }

    var marker = new google.maps.Marker(markerOptions);

}
