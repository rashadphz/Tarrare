//
//  MapManager.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 8/1/22.
//

import Foundation
import MapKit

class MapManager {
    
    static func locationCoordFromPlace(place : Place) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
    }
    
    static func markMapFromPlaces(map: MKMapView, source : Place, destination : Place) {
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.coordinate = locationCoordFromPlace(place: source)
        sourceAnnotation.title = source.name
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = locationCoordFromPlace(place: destination)
        destinationAnnotation.title = destination.name
        
        map.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
    }
    
    static func routeFromPlaces(source: Place, destination: Place, completion: @escaping(MKRoute?) -> Void) {
        let sourceLocation = locationCoordFromPlace(place: source)
        let destinationLocation = locationCoordFromPlace(place: destination)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            (response, error) -> Void in
            guard let response = response else { return }
            
            let route = response.routes[0]
            completion(route)
        })
    }
}

