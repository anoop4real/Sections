//
//  Links.swift
//  Sections
//
//  Created by Anoop M on 2021-04-30.
//

import Foundation

struct Links: Codable {
    let viaplaySections: [ViaplaySection]?

    enum CodingKeys: String, CodingKey {
        case viaplaySections = "viaplay:sections"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        viaplaySections = try values.decodeIfPresent([ViaplaySection].self, forKey: .viaplaySections)
    }
}
