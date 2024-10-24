import XCTest
import SwiftUI
import Foundation

class FakeURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), URLResponse())
    }
}



