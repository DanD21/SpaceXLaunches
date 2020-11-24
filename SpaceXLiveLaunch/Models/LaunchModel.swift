//
//  LaunchModel.swift
//  SpaceXLiveLaunch
//
//  Created by Dan Danilescu on 11/21/20.
//  Copyright © 2020 Dan Danilescu. All rights reserved.
//

import Foundation

struct LaunchModel: Codable {
    let name: String?
    let date: Double?
    let details: String?
    let rocket: String?
    let links: Links?

    struct Links: Codable {
        let patch: Patch
        let webcast: URL?
        let wikipedia: URL?
        let youtube_id: String?
    }
    
    struct Patch: Codable {
        let small: URL?
        let large: URL?
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case date = "date_unix"
        case details
        case rocket
        case links
    }
    
    //Cu asta am pierdut degeaba o noapte intreaga ca pana la urma sa fie inutila...
    
//    private enum LinksKeys: String, CodingKey {
//        case links
//    }
    
//     init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        date = try container.decode(Date.self, forKey: .date)
//        details = try container.decode(String.self, forKey: .details)
//        
//        let linksContainer = try container.nestedContainer(keyedBy: LinksKeys.self, forKey: .links)
//        links = try linksContainer.decode(Links.self, forKey: .links)
//
//       }


}
