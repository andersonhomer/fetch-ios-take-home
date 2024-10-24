import XCTest
import SwiftUI

final class ImageCacheTests: XCTestCase {
    var imageCache: ImageCache!
    var testImage: UIImage!

    override func setUp() {
        super.setUp()
        imageCache = ImageCache.shared
        testImage = UIImage(named: "ForkAndKnife")
    }

    override func tearDown() {
        imageCache = nil
        testImage = nil
        super.tearDown()
    }

    func testSetImageCachesSuccessfully() {
       
        let key = "testImageKey"

        imageCache.setImage(testImage, forKey: key)

        let cachedImage = imageCache.getImage(forKey: key)
        XCTAssertNotNil(cachedImage, "Image should be cached successfully.")
    }

    func testGetImageReturnsNilForNonExistentKey() {
       
        let key = "fakeKey"

        let cachedImage = imageCache.getImage(forKey: key)

        XCTAssertNil(cachedImage, "Image should return nil for non-existent key.")
    }

    func testGetImageAfterSettingImageWorksCorrectly() {
    
        let key = "anotherTestImageKey"
        imageCache.setImage(testImage, forKey: key)

        let cachedImage = imageCache.getImage(forKey: key)

        XCTAssertNotNil(cachedImage, "Image should be retrievable after being set.")
    }
    
}
