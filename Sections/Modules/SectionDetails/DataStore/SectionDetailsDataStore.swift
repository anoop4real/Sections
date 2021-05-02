//
//  SectionDetailsDataStore.swift
//  Sections
//
//  Created by Anoop M on 2021-05-01.
//

import Foundation


class SectionDetailsDataStore: BaseDataStore {
    
    private var networkManager: NetworkRequestable!
    private var offlineManager: OfflineFetchable!
    private var sectionDetailsItem: ResponseItem?
    init(with networkManager: NetworkRequestable = NetworkDataManager(), offlineManager: OfflineFetchable = OfflineDataManager()) {
        self.networkManager = networkManager
        self.offlineManager = offlineManager
    }
    
    // MARK: API Calls
    func fetchDetailedInfoFor(section: ViaplaySection?,completion: @escaping (ApplicationError.APIError?) -> Void) {
        
        if (ConnectivityMananger.shared().isNetworkAvailable) {
            guard let url = section?.formattedURL() else {
                completion(.generalError(reason: ApplicationConstants.Strings.inavalid_url))
                return
            }
            networkManager.executeWith(url: url) { [weak self] result in
                self?.processWith(result, completion: completion)
            }
        } else {
            guard let id = section?.id else {
                completion(.generalError(reason: ApplicationConstants.Strings.inavalid_url))
                return
            }
            offlineManager.fetchDatafor(offlineType: .sectionDetails(identifier: id)) {[weak self] (result) in
                self?.processWith(result, completion: completion)
            }
        }

    }
    
    // MARK: Convenience Functions
    func getTitle() -> String? {
        return sectionDetailsItem?.title
    }
    
    func getDescription() -> String? {
        return sectionDetailsItem?.description
    }
    
    // MARK: Process Result
    fileprivate func processWith(_ result: Result<Data, Error>, completion: @escaping (ApplicationError.APIError?) -> Void) {
        let processedResult = self.process(response: result, type: ResponseItem.self)
            switch processedResult {
            case .success(let response):
                if let _ = response.title, let _ = response.description {
                    // process
                    self.sectionDetailsItem = response
                    completion(nil)
                } else {
                    completion(.generalError(reason: ApplicationConstants.Strings.failed_fetch))
                }
            case .failure(let error):
                completion(error)
            }
    
    }
}
