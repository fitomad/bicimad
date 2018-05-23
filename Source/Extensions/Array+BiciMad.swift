//
//  Array+BiciMad.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 16/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

/**
    Operaciones para `Array` que contengan 
    elementos de tipo `Station`
*/
public extension Array where Element == Station
{
    /// Bicicletas disponibles al usuario en este momento
    /// en todas las estaciones
    public var freeBikes: Int
    {
        return self.filter({ $0.isReady }).map({ $0.bikesDocked }).reduce(0) { $1 + $0 } 
    }
    
    /// Bicicletas que están siendo usadas en este momento
    /// Quiere decir que están en circulación
    public var bikesInUse: Int
    {
        return self.map({ $0.freeBases }).reduce(0) { $1 + $0 }
    }
    
    /// Estaciones operativas
    public var stationsAvailables: Int
    {
        return self.filter({ $0.isReady }).count
    }
    
    /// Estaciones fuera de servicio
    public var stationsUnavailables: Int
    {
        return (self.count - self.stationsAvailables)
    }
    
    /// Cantidad de reservas en un momento dado
    public var reservationsCount: Int
    {
        return self.map({ $0.reservations }).reduce(0) { $1 + $0 } 
    }
    
    /// Nivel medio de ocupación de todas las estaciones
    public var serviceOcuppationLevel: Ocuppation?
    {
        let sum_level = self.map({ $0.occupationLevel.rawValue }).reduce(0) { $1 + $0 }
        let average_level = sum_level / self.count
        
        return Ocuppation(rawValue: average_level)
    }
    
    /**
        La cantidad de estaciones que están en un 
        estado de ocupación dado.

        - Parameter occupaction: El nivel sobre el que se pregunta
        - Returns: El número de estaciones.
    */
    public func stationsCount(by occupation: Ocuppation) -> Int
    {
        return self.filter({ $0.occupationLevel == occupation }).count
    }
}
