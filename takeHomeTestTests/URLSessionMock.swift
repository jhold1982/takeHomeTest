//
//  URLSessionMock.swift
//  takeHomeTestTests
//
//  Created by Justin Hold on 6/11/25.
//

@testable import takeHomeTest
import Foundation

struct URLSessionMock: DataFetching {
    
    var data: Data
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        (data, URLResponse())
    }
}
