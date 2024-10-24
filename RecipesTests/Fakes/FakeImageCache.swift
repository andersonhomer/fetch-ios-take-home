import SwiftUI
import UIKit

class FakeImageCache: ImageCacheProtocol {

    var shouldReturnError = false
    var cachedImages: [String: Image] = [:]
    
   
    func getImage(forKey key: String) -> Image? {
        if shouldReturnError {
            return nil
        } else {
            return cachedImages[key]
        }
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cachedImages[key] = Image(uiImage: image)
    }
}
