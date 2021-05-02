//
//  BaseDataStore.swift
//  Sections
//
//  Created by Anoop M on 2021-04-30.
//

import Foundation

class BaseDataStore {
    func process<T: Codable>(response: Result<Data, Error>, type: T.Type) -> Result<T, ApplicationError.APIError> {
        switch response {
        case .success(let data):
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(type, from: data)
                return .success(json)
            } catch {
                return .failure(handle(error: error))
            }
        case .failure(let err):
            return .failure(handle(error: err))
        }
    }

    private func handle(error: Error) -> ApplicationError.APIError {
        if let err = error as NSError? {
            switch err.code {
            case 401:
                return ApplicationError.APIError.authenticationFailed
            case 403:
                return ApplicationError.APIError.forbidden
            case 404:
                return ApplicationError.APIError.notFound
            case NSURLErrorNotConnectedToInternet:
                return ApplicationError.APIError.notConnectedToInternet
            default:
                return ApplicationError.APIError.unknown
            }

        } else {
            return .unknown
        }
    }
}
