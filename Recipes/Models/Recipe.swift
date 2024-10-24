import Foundation

struct Recipe: Identifiable, Codable, Equatable {
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let id: UUID
    let sourceUrl: URL?
    let youtubeUrl: URL?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case id = "uuid"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

struct RecipeData: Codable {
    let recipes: [Recipe]
}


extension Recipe {
    public static func fixture(
        cuisine: String = "American",
        name: String = "Banana Pancakes",
        photoUrlLarge: URL? = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
        photoUrlSmall: URL? = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
        id: UUID = UUID(uuidString: "f8b20884-1e54-4e72-a417-dabbc8d91f12")!,
        sourceUrl: URL? = nil,
        youtubeUrl: URL? = nil
    ) -> Self {
        return .init(
            cuisine: cuisine,
            name: name,
            photoUrlLarge: photoUrlLarge,
            photoUrlSmall: photoUrlSmall,
            id: id,
            sourceUrl: sourceUrl,
            youtubeUrl: youtubeUrl
        )
    }
}
