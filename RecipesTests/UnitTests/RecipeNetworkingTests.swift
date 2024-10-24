import XCTest
import UIKit
import SwiftUI

final class RecipeNetworkingTests: XCTestCase {
    var recipeNetworking: RecipeNetworking!
    var fakeURLSession: FakeURLSession!
    var fakeImageCache: FakeImageCache!

    override func setUp() {
        super.setUp()
        fakeImageCache = FakeImageCache()
    }

    override func tearDown() {
        recipeNetworking = nil
        fakeURLSession = nil
        fakeImageCache = nil
        super.tearDown()
    }

    func testFetchRecipesWithValidDataReturnsRecipesSuccessfully() async throws {
        
        let recipeData = """
        {
            "recipes" : [
          {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                },
                {
                    "cuisine": "British",
                    "name": "Apple & Blackberry Crumble",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                },
                {
                    "cuisine": "British",
                    "name": "Apple Frangipan Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                    "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                    "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
                }
        ]
        }
        """.data(using: .utf8)
        
        fakeURLSession = FakeURLSession(data: recipeData, error: nil)
        recipeNetworking = RecipeNetworking(urlSession: fakeURLSession, imageCache: fakeImageCache)

        let recipes = try await recipeNetworking.fetchRecipes()

        XCTAssertEqual(recipes.count, 3)
        XCTAssertEqual(recipes[0].name, "Apam Balik")
        XCTAssertEqual(recipes[1].name, "Apple & Blackberry Crumble")
        XCTAssertEqual(recipes[2].name, "Apple Frangipan Tart")
    }


    func testFetchRecipesWithEmptyDataReturnsEmptyRecipesArray() async throws {
        // Arrange
        let recipeData = """
        {
            "recipes": []
        }
        """.data(using: .utf8)
        
        fakeURLSession = FakeURLSession(data: recipeData, error: nil)
        recipeNetworking = RecipeNetworking(urlSession: fakeURLSession, imageCache: fakeImageCache)

        // Act
        let recipes = try await recipeNetworking.fetchRecipes()

        // Assert
        XCTAssertTrue(recipes.isEmpty, "Recipes should be empty")
    }


    func testFetchRecipesWithMalformedDataThrowsError() async throws {
      
        let recipeData = """
        {
            "recipes" : [
          {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                },
                {
                    "cuisine": "British",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                },
                {
                    "cuisine": "British",
                    "name": "Apple Frangipan Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                    "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                    "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
                }
        ]
        }
        """.data(using: .utf8)
        
        fakeURLSession = FakeURLSession(data: recipeData, error: nil)
        recipeNetworking = RecipeNetworking(urlSession: fakeURLSession, imageCache: fakeImageCache)
        
        do {
            _ = try await recipeNetworking.fetchRecipes()
            XCTFail("Expected error but no error was thrown")
        } catch {
            XCTAssertNotNil(error, "Should throw error for malformed data")
        }
    }

    func testLoadImageWithCachedImageReturnsImageSuccessfully() async throws {
        let urlString = "https://example.com/image.jpg"
        let url = URL(string: urlString)!
        let image = Image("ForkAndKnife")
        fakeImageCache.cachedImages = [urlString:image]
        fakeURLSession = FakeURLSession(data: nil, error: nil)
        recipeNetworking = RecipeNetworking(urlSession: fakeURLSession, imageCache: fakeImageCache)

        let fetchedImage = try await recipeNetworking.loadImage(from: url)

        XCTAssertNotNil(fetchedImage, "Image should be loaded from cache")
    }


    func testLoadImageFromNetworkReturnsImageSuccessfully() async throws {
        let url = URL(string: "https://example.com/image.jpg")!
        let imageData = UIImage(systemName: "photo")!.jpegData(compressionQuality: 1.0)
        fakeURLSession = FakeURLSession(data: imageData, error: nil)
        recipeNetworking = RecipeNetworking(urlSession: fakeURLSession, imageCache: fakeImageCache)

        let image = try await recipeNetworking.loadImage(from: url)
        
        XCTAssertNotNil(image, "Image should be fetched from network")
        XCTAssertEqual(fakeImageCache.cachedImages.count, 1)
    }


    func testLoadImageWithNetworkErrorThrowsErrorAsExpected() async throws {
        
        let url = URL(string: "https://example.com/image.jpg")!
        fakeURLSession = FakeURLSession(data: nil, error: URLError(.cannotLoadFromNetwork))
        recipeNetworking = RecipeNetworking(urlSession: fakeURLSession, imageCache: fakeImageCache)

       
        do {
            _ = try await recipeNetworking.loadImage(from: url)
            XCTFail("Expected error but no error was thrown")
        } catch {
            XCTAssertNotNil(error, "Should throw network error")
        }
    }
}
