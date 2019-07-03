import { map } from './google-map.js';

const service = new google.maps.places.PlacesService(map);

/**
 * Retrieves nearby places from the google places API
 * @param  {number[]} location   the center of the circle to search about in the form [lat, lng]
 * @param  {number} radius       the radius of the circle to search about
 * @param  {Object} [options={}] additional options to be attached to the request
 * @return {Promise}             resolves/rejects once the places API returns data
 */
export function getPlaces(location, radius, options = {}) {
    let request = {
        location: new google.maps.LatLng(...location),
        radius,
        types: ['resturant', 'food'],
        ...options
    };

    return new Promise((resolve, reject) => {
        service.nearbySearch(request, (results, status) => {
            (status == google.maps.places.PlacesServiceStatus.OK) ?
                resolve(results) :
                reject(results, status);
        });
    });
}
