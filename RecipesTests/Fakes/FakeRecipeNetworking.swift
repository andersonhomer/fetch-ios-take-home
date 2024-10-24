import SwiftUI

class FakeRecipeNetworking: RecipeNetworkingProtocol {
    var shouldReturnError = false
    var image: Image?
    var recipes: [Recipe] = []
    
    func fetchRecipes() async throws -> [Recipe] {
        if shouldReturnError {
            throw NSError(domain: "Recipe fetching error", code: 1, userInfo: nil)
        }
        return recipes // Return the mock recipes
    }

    func loadImage(from url: URL) async throws -> Image {
        if shouldReturnError {
            throw NSError(domain: "Image loading error", code: 1, userInfo: nil)
        }
        return image ?? Image(systemName: "photo")
    }
}
