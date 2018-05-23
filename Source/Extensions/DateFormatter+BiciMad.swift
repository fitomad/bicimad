//
//  DateFormatter+BiciMad.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 16/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

/**
    El formato de fecha devuelto por el servicio
    BiciMAD no se ajusta al esperado por JSONDecoder.

    Por eso creamos nuestra propia *estrategia* de
    decodificación para que la empleemos con JSONDecoder
*/
extension DateFormatter 
{
    /**
        El formato que llega es...

        ```
        16-05-2018 10:14:35.496
        ```
    */
    static let bicimadISO8601: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss.SSS"

        return formatter
    }()
}