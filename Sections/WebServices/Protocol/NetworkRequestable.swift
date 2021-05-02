//
//  NetworkRequestable.swift
//
//  Created by Anoop M on 2021-04-23.
//

import Foundation

protocol NetworkRequestable {
    func executeWith(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
