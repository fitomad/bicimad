//
//  StationMapAnnotation.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 10/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation

public class StationMapAnnotation: NSObject, MKAnnotation
{
    ///
    public private(set) var station: Station

    //
    // MARK: - MKAnnotation Protocol
    //

    /// Coordenadas de la anotación
    public var coordinate: CLLocationCoordinate2D
    {
        return self.station.location!.coordinate
    }

    //
    // MARK: - Propiedades personalizadas
    //

    /// Identificador único de la estación BiciMAD
    public var stationIdentifier: Int
    {
        return self.station.stationIdentifier
    }

    /// Nivel de ocupación de esta estación
    public var occupationLevel: Ocuppation
    {
        return self.station.occupationLevel
    }

    /// Color asociado al nivel de ocupación
    public var annotationColor: UIColor
    {
        switch self.station.occupationLevel
        {
            case .low:
                return UIColor(red: 0.71, green: 0.99, blue: 0.16, alpha: 1.0)
            case .medium:
                return UIColor(red: 0.98, green: 0.89, blue: 0.24, alpha: 1.0)
            case .high:
                return UIColor(red: 1.0, green: 0.31, blue: 0.47, alpha: 1.0)
            case .unavailable:
                return UIColor(red: 1.0, green: 0.42, blue: 0.82, alpha: 1.0)
        }
    }

    /**
        Annotation basada en una estación 
    */
    public init(for station: Station)
    {
        self.station = station
    }
}
