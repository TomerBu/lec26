//
//  Landmarks.swift
//  Lec26Location
//
//  Created by Tomer Buzaglo 
//  
//


import Foundation
import Combine

struct Landmarks{
    //read json from file as [Landmark]
    
    static func load()-> AnyPublisher<Array<Landmark>, Error>{
        //url for file with extension
        guard let url = Bundle.main.url(
            forResource: "camp_il",
            withExtension: "json"
        ) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {(data, res) ->Data in
                return data
            }.decode(type: [Landmark].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main, options: nil)
            .eraseToAnyPublisher()
    }
}
