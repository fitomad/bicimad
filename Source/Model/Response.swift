//
//  Response.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 16/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

/**
    Represeta una respuesta del servicio de BiciMAD
*/
internal struct Response: Codable
{
    /// Código de respuesta
    internal var code: String
    /// Texto descriptivo
    internal var responseDescription: String
    /// Identificado del API
    internal var apiIdentifier: String
    /// Versión del API
    internal var apiVersion: String
    /// Fechad de la solicitud
    internal var requestedAt: Date
    /// Los datos de la/s estación/es
    internal var results: Result

    /**
        Set the JSON key values.
    */
	private enum CodingKeys: String, CodingKey
	{
	    case code = "code"
	    case responseDescription = "description"
	    case apiIdentifier = "whoAmI"
        case apiVersion = "version"
        case requestedAt = "time"
        case results = "data"
	}
}
