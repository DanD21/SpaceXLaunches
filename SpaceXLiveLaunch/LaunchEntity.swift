//
//  LaunchEntity.swift
//  SpaceXLiveLaunch
//
//  Created by Dan Danilescu on 11/24/20.
//  Copyright © 2020 Dan Danilescu. All rights reserved.
//

import Foundation

struct LaunchEntity {
    let name: String?
    let date: Int?
    let details: String?
    let rocket: String?
    let links: Links?

    struct Links {
        let patch: Patch
        let webcast: URL?
        let wikipedia: URL?
    }

    struct Patch {
        let small: URL?
        let large: URL?
    }
}
