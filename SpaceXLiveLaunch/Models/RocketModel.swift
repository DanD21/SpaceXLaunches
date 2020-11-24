//
//  RocketModel.swift
//  SpaceXLiveLaunch
//
//  Created by Dan Danilescu on 11/24/20.
//  Copyright © 2020 Dan Danilescu. All rights reserved.
//

import Foundation

struct RocketModel: Codable {
    let name: String?
    let mass: Mass
    
    struct Mass: Codable {
        let kg: Int?
        let lbs: Int?
    }
}
