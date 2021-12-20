//
//  LandmarkAnnotation.swift
//  Lec26Location
//
//  Created by Tomer Buzaglo 
//  
//



class LandmarkAnnotation: Annotation{
    //props:
    let landmark: Landmark
    
    //init
    init(_ landmark: Landmark){
        self.landmark = landmark
        
        super.init(
            landmark.coordinate,
            title: landmark.name,
            subtitle: landmark.vendorName
        )
    }
}
