//
//  BiciMADResult.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 10/4/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//
import Foundation

/*
    Resultado de las operaciones con el API de BiciMAD.

    En este caso no es necesario que la enumeración sea
    genérica ya que el servicio siempre devuelve un 
    array de *estaciones*, no importa si preguntamos por
    todas las estaciones o por una sola.
*/
public enum BiciMADResult
{
    /// La operación es correcta. 
    /// Devolvemos la información relativa a las
    /// estaciones
    case success(stations: [Station])
    /// Algo ha salido mal... :-(
    case error(message: String)
}
