//
//  OfflineDataManager.swift
//  Sections
//
//  Created by Anoop M on 2021-05-01.
//

import Foundation

enum OfflineDataType {
    case sections
    case sectionDetails(identifier: String)
    
    var resourceName: String {
        
        switch self {
        
        case .sections:
            return "Sections"
        case .sectionDetails(_):
            return "SectionDetails"
        }
    }
    
    var identifier: String? {
        switch self {
        
        case .sections:
            return nil
        case .sectionDetails(identifier: let identifier):
            return identifier
        }
    }
}

class OfflineDataManager: OfflineFetchable {
    func fetchDatafor(offlineType: OfflineDataType, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let pathURL = Bundle.main.url(forResource: offlineType.resourceName, withExtension: "json") else {
            let err = NSError(domain: "Offline", code: 999, userInfo: ["mesage": "No data found"])
            completion(.failure(err))
            return
        }
        do {
            let jsonData = try Data(contentsOf: pathURL, options: .mappedIfSafe)
            if let identifier = offlineType.identifier {
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String: Any]
                if let items = jsonResult[identifier] {
                    let jsonFinalData = try JSONSerialization.data(withJSONObject: items, options: [])
                    completion(.success(jsonFinalData))
                    return
                }
            }

            completion(.success(jsonData))
        } catch(let error) {
            completion(.failure(error))
        }
    }
}
