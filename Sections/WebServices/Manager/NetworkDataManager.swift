//
//  NetworkDataManager.swift
//
//  Created by Anoop M on 2021-04-23.
//

import Foundation

class NetworkSession {
    static let sharedSession: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30
        let urlSession = URLSession(configuration: .default)
        return urlSession
    }()
}

class NetworkDataManager: NetworkRequestable {
    func executeWith(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = NetworkSession.sharedSession.dataTask(with: url) { data, _, error in

            if let err = error {
                completion(.failure(err))
                return
            } else if let data = data {
                completion(.success(data))
            } else {
                let err = NSError(domain: "Unknown", code: 0, userInfo: nil)
                completion(.failure(err))
            }
        }
        task.resume()
    }
}
