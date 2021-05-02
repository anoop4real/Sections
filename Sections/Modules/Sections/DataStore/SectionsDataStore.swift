//
//  SectionsDataStore.swift
//  Sections
//
//  Created by Anoop M on 2021-04-30.
//

import Foundation

class SectionsDataStore: BaseDataStore {
    private var networkManager: NetworkRequestable!
    private var offlineManager: OfflineFetchable!
    private lazy var viaplaySections = [ViaplaySection]()
    init(with networkManager: NetworkRequestable = NetworkDataManager(), offlineManager: OfflineFetchable = OfflineDataManager()) {
        self.networkManager = networkManager
        self.offlineManager = offlineManager
    }

    fileprivate func processWith(_ result: Result<Data, Error>, completion: @escaping (ApplicationError.APIError?) -> Void) {
        let processedResult = process(response: result, type: ResponseItem.self)
        switch processedResult {
        case .success(let response):
            if let links = response.links, let sections = links.viaplaySections {
                // process
                viaplaySections = sections
                completion(nil)
            } else {
                completion(.generalError(reason: ApplicationConstants.Strings.failed_fetch))
            }
        case .failure(let error):
            completion(error)
        }
    }

    func fetchSections(completion: @escaping (ApplicationError.APIError?) -> Void) {
        
        if (ConnectivityMananger.shared().isNetworkAvailable) {
            guard let url = URL(string: APIConstants.iOSURL) else {
                completion(.generalError(reason: ApplicationConstants.Strings.inavalid_url))
                return
            }
            networkManager.executeWith(url: url) { [weak self] result in

                self?.processWith(result, completion: completion)
            }
        } else {
            offlineManager.fetchDatafor(offlineType: .sections) {[weak self] (result) in
                self?.processWith(result, completion: completion)
            }
        }

    }

    // MARK: UITableView Convenience Functions

    func numberOfRowsInSection(section: Int) -> Int {
        return viaplaySections.count
    }

    func itemAt(index: Int) -> ViaplaySection? {
        guard let item = viaplaySections[safeIndex: index] else {
            return nil
        }
        return item
    }
}
