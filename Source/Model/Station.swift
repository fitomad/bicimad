//
//  Station.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 16/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation
import CoreLocation

/**
    Una estación de BiciMAD
*/
public struct Station: Codable
{
    /// Identificador único
    public var stationIdentifier: Int
    /// Nombre
    public var name: String
    /// Número de la estación. 
    /// Puede contener caracteres.
    public var stationNumber: String
    /// Dirección donde se encuentra
    public var address: String
    /// Latitud
    private var latitudeDescription: String
    /// Longitud
    private var longitudeDescription: String
    /// Si la estación está activa
    private var activate: Int
    /// Si **no** se encuentra disponible
    private var nonAvailable: Int
    /// La cantidad de bases (docks) de la estación
    public var bases: Int
    /// Las bicis que están ancladas y a 
    /// disposición de los usuarios
    public var bikesDocked: Int
    /// Los anclajes vacíos
    public var freeBases: Int
    /// Las reservas pendientes en la estación
    public var reservations: Int  
    /// El nivel de ocupación
    public var occupationLevel: Ocuppation

    /**
        Set the JSON key values.
    */
	private enum CodingKeys: String, CodingKey
	{
	    case stationIdentifier = "id"
        case name = "name"
	    case stationNumber = "number"
        case address = "address"
        case latitudeDescription = "latitude"
	    case longitudeDescription = "longitude"
        case activate = "activate"
        case nonAvailable = "no_available"
        case bases = "total_bases"
        case bikesDocked = "dock_bikes"
        case freeBases = "free_bases"
        case reservations = "reservations_count"
        case occupationLevel = "light"
	}
}

//
// MARK: - Computed Properties
//

extension Station
{
    /// Si está activa
    public var isActive: Bool
    {
        return self.activate == 1
    }
    
    /// Si está disponible
    public var isAvailable: Bool
    {
        return self.nonAvailable == 0    
    }
    
    /// Si está lista para el público
    public var isReady: Bool
    {
        return (self.isActive && self.isAvailable)
    }
    
    /// La situación de la estación
    public var location: CLLocation?
    {
        guard let latitude = Double(latitudeDescription), let longitude = Double(longitudeDescription) else
        {
            return nil
        }
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

//
// MARK: - Equatable Protocol
//

extension Station: Equatable
{
    public static func ==(lhs: Station, rhs: Station) -> Bool
    {
        return lhs.stationIdentifier == rhs.stationIdentifier
    }

    public static func !=(lhs: Station, rhs: Station) -> Bool
    {
        return !(lhs == rhs)
    }
}