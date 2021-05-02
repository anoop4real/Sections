//
//  ResponseItem.swift
//  Sections
//
//  Created by Anoop M on 2021-04-30.
//

import Foundation

struct ResponseItem: Codable {
    let type: String?
    let pageType: String?
    let title: String?
    let description: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case type
        case pageType
        case title
        case description
        case links = "_links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        pageType = try values.decodeIfPresent(String.self, forKey: .pageType)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }
}
