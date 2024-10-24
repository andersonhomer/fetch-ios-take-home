import Foundation
import SwiftUI

/// The view model for the image view. This just shoots of a request to fetch the image and returns an image if successful.
@MainActor
class ImageViewModel: ObservableObject {
    @Published var image: Image?
    private let networking: RecipeNetworkingProtocol

       init(networking: RecipeNetworkingProtocol = RecipeNetworking.shared) {
           self.networking = networking
       }
    
    func loadImage(url: URL?) async {
       
        do {
            if let url {
                let fetchedImage = try await networking.loadImage(from: url)
                image = fetchedImage
            }
                
        } catch {
                
        }
    }
}
