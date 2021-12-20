//
//  MapsViewController.swift
//  Lec26Location
//
//  Created by Tomer Buzaglo
//
//

import UIKit
import MapKit
import Combine

class MapsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var subscriptions: Set<AnyCancellable> = []
    var landmarks: [Landmark] = []{
        didSet{
            //add annotations:
            mapView.addAnnotations(landmarks.map(LandmarkAnnotation.init))
        }
    }
    
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            fatalError("No such segment")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Landmarks.load().sink { completion in
            print(completion)
        } receiveValue: {[weak self] landmarks in
            self?.landmarks = landmarks
            print(landmarks)
        }.store(in: &subscriptions)
        
        //customise the annotations:
        mapView.delegate = self
    }
}

extension MapsViewController: MKMapViewDelegate{
    
    //how do we present the annotation: MKAnnotationView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //the annotations we added extend LandmarkAnnotation -> has the prop landmark.
        guard let landmarkAnnotation = annotation as? LandmarkAnnotation
        else {return nil}
      
        var av = mapView
            .dequeueReusableAnnotationView(withIdentifier: "landmark") as? MKMarkerAnnotationView
        
        if av == nil{
            av = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "landmark")
        }
        
        av?.markerTintColor = landmarkAnnotation.landmark.color
        return av
    }
}
