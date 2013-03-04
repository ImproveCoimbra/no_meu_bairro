var loading_location_message;
var location_found_message;
var location_not_found_message;


if ($('form#new_report').length > 0) {
    loading_location_message = $("#loading_location_message");
    location_found_message = $("#location_found_message");
    location_not_found_message = $("#location_not_found_message");
}

function findLocation() {

    loading_location_message.show(500);
    location_not_found_message.hide(500);

    navigator.geolocation.getCurrentPosition(
        foundLocation,
        noLocation,
        { enableHighAccuracy: true, timeout: 30000, maximumAge: 0 }
    );
}

function foundLocation(position) {
    loading_location_message.hide(500);
    location_found_message.show(500);

    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    document.getElementById('latitude').value = latitude;
    document.getElementById('longitude').value = longitude;

}

function noLocation() {
    loading_location_message.hide(500);
    location_not_found_message.show(500);
}

$(document).ready(function () {

    if ($('form#new_report').length > 0) {
        findLocation();
    }

});
