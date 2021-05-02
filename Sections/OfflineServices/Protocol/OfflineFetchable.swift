//
//  OfflineFetchable.swift
//  Sections
//
//  Created by Anoop M on 2021-05-01.
//

import Foundation

protocol OfflineFetchable {
    func fetchDatafor(offlineType: OfflineDataType, completion: @escaping (Result<Data, Error>) -> Void)
}
