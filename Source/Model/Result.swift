//
//  Result.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 16/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

/**
    Los datos de las estación
*/
internal struct Result: Codable
{
    /// Las estaciones devueltas en el `JSON`
    internal var stations: [Station]
    
    /// Una estación dentro del array de estaciones
    /// en base a su posición dentro del mismo.
    internal subscript(index: Int) -> Station?
    {
        return self.stations[index]
    }
    
    //
    // MARK: Array properties implementation
    //

    // La primera estación
    internal var first: Station?
    {
        return self.stations.first
    }
    
    // La última
    internal var last: Station?
    {
        return self.stations.last
    }

    // Total de estaciones
    internal var count: Int
    {
        return self.stations.count
    }
}