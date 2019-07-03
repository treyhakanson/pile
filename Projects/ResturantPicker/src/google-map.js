export let map;

/**
 * Initializes the google map
 * @param  {Object} mapEl        the element to initialize the map into
 * @param  {number[]} location   the ceneterpoint of the map, in the form [lat, lng]
 * @param  {Object} [options={}] additional options to be added to the map
 * @return {Object}              the created map object
 */
export function initializeMap(mapEl, location, options = {}) {
    let location = new google.maps.LatLng(...location);
    let _map = new google.maps.Map(mapEl, {
        center: columbus,
        zoom: 15,
        scrollwheel: false,
        ...options
    });
    map = _map; // store a reference to the map for export
    return _map; // return the map as well
}
