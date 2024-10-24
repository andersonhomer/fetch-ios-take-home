import XCTest
import SwiftUI

@MainActor
final class ImageViewModelTests: XCTestCase {
    var imageViewModel: ImageViewModel!
    var fakeNetworking: FakeRecipeNetworking!

    override func setUp() {
        super.setUp()
        fakeNetworking = FakeRecipeNetworking()
        imageViewModel = ImageViewModel(networking: fakeNetworking)
    }

    override func tearDown() {
        imageViewModel = nil
        fakeNetworking = nil
        super.tearDown()
    }

    func testLoadImageSuccessfully() async {
        let expectedImage = Image(systemName: "testImage")
        fakeNetworking.image = expectedImage
        let testUrl = URL(string: "https://example.com/testImage")!
        
        await imageViewModel.loadImage(url: testUrl)
        
        XCTAssertEqual(imageViewModel.image, expectedImage)
    }

    func testLoadImageThrowsError() async {
       
        fakeNetworking.shouldReturnError = true
        let testUrl = URL(string: "https://example.com/testImage")!
        
        await imageViewModel.loadImage(url: testUrl)
        
        XCTAssertNil(imageViewModel.image) // Ensure image is nil on error
    }
}
