import Foundation
import SwiftUI

protocol RecipeNetworkingProtocol {
    func fetchRecipes() async throws -> [Recipe]
    func loadImage(from url: URL) async throws -> Image 
}

/// This is the class responsible for making all the network requests for data. Fetching the recipes and loading the image data
class RecipeNetworking: RecipeNetworkingProtocol {
    private let urlSession: URLSessionProtocol
    private let imageCache: ImageCacheProtocol
    
    static let shared = RecipeNetworking()
    
    init(urlSession: URLSessionProtocol = URLSession.shared, imageCache: ImageCacheProtocol = ImageCache.shared) {
        self.urlSession = urlSession
        self.imageCache = imageCache
    }
    
    /// This is the default url to fetch valid data.
    ///  We can change this out to test for empty data and malformed data
    private static let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    /// Simple fetch and decode of the recipe data into an array of our Domain object models Recipe.
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: RecipeNetworking.urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await urlSession.data(from: url)
        let decodedData = try JSONDecoder().decode(RecipeData.self, from: data)
        return decodedData.recipes
    }
    
    /// Image loader function. We first check for a cached image before attempting the network fetch to load the image .
    /// After a successful fetch we cache the image for future use.
    func loadImage(from url: URL) async throws -> Image {
        
        if let cachedImage = imageCache.getImage(forKey: url.absoluteString) {
            return cachedImage
        }

        let (data, _) = try await urlSession.data(from: url)
        
        guard let uiImage = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        let image = Image(uiImage: uiImage)
        imageCache.setImage(uiImage, forKey: url.absoluteString)
        return image
    }
}
