//
//  Ocuppation.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 16/5/18.
//  Copyright © 2018 desappstre {eStudio}. All rights reserved.
//

import Foundation

/**
    Nivel de ocupación de una estación
*/
public enum Ocuppation: Int, Codable
{
    case low = 0
    case medium = 1
    case high = 2
    case unavailable = 3
}