//
//  HttpResult.swift
//  BiciKit
//
//  Created by Adolfo on 16/5/18.
//  Copyright (c) 2018 Desappstre Studio. All rights reserved.
//

import Foundation

/**
 Posibles resultados al ejecutat una peticion HTTP.
 
 Los posibles valores devolvemos son:
 
 - Success: Recuperamos el contenido del stream
 - RequestError: Problema en la peticion HTTP
 - ConnectionError: Error general
 */
internal enum HttpResult
{
    /// La operacion ha terminado bien.
    /// Devolvemos el stream de datos reacuperados
    case success(data: Data)
    /// Algo ha salido mal.
    /// Devolvemos un mensaje con la descripcion del error
    /// y el codigo HTTP asociado
    case requestError(code: Int, message: String)
    /// Error general
    case connectionError(reason: String)
}