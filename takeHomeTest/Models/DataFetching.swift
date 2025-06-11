//
//  DataFetching.swift
//  takeHomeTest
//
//  Created by Justin Hold on 6/11/25.
//

import Foundation

protocol DataFetching: Sendable {
    
    func data(from url: URL) async throws -> (Data, URLResponse)
    
}

extension URLSession: DataFetching { }


