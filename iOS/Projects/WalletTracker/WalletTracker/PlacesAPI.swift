//
//  PlacesAPI.swift
//  WalletTracker
//
//  Created by David Hakanson on 10/21/17.
//  Copyright © 2017 David Hakanson. All rights reserved.
//

import GooglePlaces

class PlacesAPI {

    private let client: GMSPlacesClient
    
    init() {
        GMSPlacesClient.provideAPIKey("AIzaSyAR1fsRDbHp0D-RBOr9vFrl24Vi54czjuU")
        client = GMSPlacesClient.shared()
    }
    
    func getPlaces() {
        client.currentPlace { (placeList, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            
            guard let placeList = placeList else { return }
            
            for place in placeList.likelihoods {
                print(place)
            }
        }
    }
    
}
