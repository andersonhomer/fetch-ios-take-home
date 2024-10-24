import SwiftUI
import UIKit

/// This is a simple class that implements a disk cache for our images. We can retrieve and store images to the local disk here.
protocol ImageCacheProtocol {
    func getImage(forKey key: String) -> Image?
    func setImage(_ image: UIImage, forKey key: String)
}

class ImageCache: ImageCacheProtocol {
    static let shared = ImageCache()

    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    init() {
       
        let directories = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = directories[0].appendingPathComponent("ImageCache", isDirectory: true)
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
            }
        }
    }
    
    /// We get the image from disk here.
    func getImage(forKey key: String) -> Image? {
        let sanitizedKey = sanitizeKey(key)
        let fileURL = cacheDirectory.appendingPathComponent(sanitizedKey)
        
        // Check if file exists and load data
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                if let uiImage = UIImage(data: data) {
                    return Image(uiImage: uiImage)
                } else {
                }
            } catch {
            }
        } else {
        }
        
        return nil
    }
    
    /// Save image to disk
    func setImage(_ image: UIImage, forKey key: String) {
        let sanitizedKey = sanitizeKey(key)
        let fileURL = cacheDirectory.appendingPathComponent(sanitizedKey)
        
        
        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
            } catch {
            }
        } else {
        }
    }
    
    /// Helper function to sanitize keys for file paths . We need this because the url we provide as a key would cause issues with creating a valid filePath.
    private func sanitizeKey(_ key: String) -> String {
        // Replace characters that aren't allowed in file names
        return key.replacingOccurrences(of: "/", with: "-")
                   .replacingOccurrences(of: ":", with: "-")
    }
}
