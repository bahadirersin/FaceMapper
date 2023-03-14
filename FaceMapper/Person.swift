//
//  Person.swift
//  FaceMapper
//
//  Created by Bahadır Ersin on 14.03.2023.
//

import CoreLocation
import Foundation

struct Person:Codable, Equatable, Identifiable{
    var id:UUID
    var imageURL: URL
    var name:String
    var meetLongitude:Double
    var meetLatitude:Double
    
    var meetingPoint:CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: meetLatitude, longitude: meetLongitude)
    }
    
    init(name:String, imageURL:URL, longitude:Double, latitude:Double){
        id = UUID()
        self.imageURL = imageURL
        self.name = name
        self.meetLatitude = latitude
        self.meetLongitude = longitude
    }
    
    static func ==(lhs: Person, rhs: Person)-> Bool{
        lhs.id == rhs.id
    }
}
