// NOTE: this will be generated based of the user's location; won't be hardcoded
let columbus = new google.maps.LatLng(39.961292, -82.999765);

let map = new google.maps.Map(document.getElementById('map'), {
    center: columbus,
    zoom: 15,
    scrollwheel: false
});

let request = {
    location: columbus,
    // NOTE: radius will change based on how how far the user specifies they are
    // willing to go
    radius: 500,
    types: ['resturant', 'food']
};

let service = new google.maps.places.PlacesService(map);
service.nearbySearch(request, (results, status) => {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
        console.log(results, status);
    } else {
        console.error(results, status);
    }
});
