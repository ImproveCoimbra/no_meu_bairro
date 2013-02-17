$(document).ready(function() {

  function findLocation() {
      navigator.geolocation.getCurrentPosition(foundLocation, noLocation);
  }
  function foundLocation(position) {
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      document.getElementById('latitude').value = latitude;
      document.getElementById('longitude').value = longitude;
  }
  function noLocation() {
      alert('Não foi possível validar a localização');
  }

  if ($('form#new_report').length > 0) {
    findLocation();
  }

});
