function initialize_map(elementId, latitude, longitude) {
    alert( latitude +" "+ longitude)
    var mapOptions = {
        center: new google.maps.LatLng(latitude, longitude),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById(elementId),
        mapOptions);
}
