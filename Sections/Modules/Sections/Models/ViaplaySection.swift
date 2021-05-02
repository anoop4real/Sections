//
//  ViaplaySection.swift
//  Sections
//
//  Created by Anoop M on 2021-04-30.
//

import Foundation

struct ViaplaySection: Codable {
    let id: String?
    let title: String?
    let href: String?
    let type: String?
    let name: String?
    let templated: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case href
        case type
        case name
        case templated
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        href = try values.decodeIfPresent(String.self, forKey: .href)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        templated = try values.decodeIfPresent(Bool.self, forKey: .templated)
    }
    func formattedURL() -> URL? {
        if let href = self.href, let urlString = href.components(separatedBy: "{").first, let url = URL(string: urlString) {
            return url
        }
        return nil
    }
}
