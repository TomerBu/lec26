//
//  LocationManager.swift
//  Lec26Location
//
//  Created by Tomer Buzaglo 
//  
//


import CoreLocation

class LocationManager:NSObject{
    //props:
    private let clm = CLLocationManager()
    
    //static props:
    static let shared = LocationManager()
    
    private override init(){
        //delegate: permission? location changed? heading changed
        super.init()
        clm.delegate = self
    }
    
    //last known location:
    var location: CLLocation?{
        clm.location
    }
}

extension LocationManager: CLLocationManagerDelegate{
    //runs first when the object is initialized
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
    
        case .authorizedAlways, .authorizedWhenInUse:
            print("we have permission")
            //show the user location on the map
        case .denied, .restricted:
            print("no permission")
            //go to settings
        default:
            print("unknown enum cases")
            break
        }
    }
}
