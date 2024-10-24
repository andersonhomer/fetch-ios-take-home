import SwiftUI

/// This is the main View for an individual Recipe.
/// It takes a Recipe object and displays the required data.
struct RecipeView: View {
    let recipe: Recipe
    var body: some View {
        VStack (alignment: .leading) {
            ImageView(imageURL: recipe.photoUrlLarge)
            VStack(alignment: .leading) {
                TitleText(text: recipe.name)
                BodyText(text: recipe.cuisine)
            }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
        .padding()
        .background(Branding.cardColor)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}

/// This is responsible for the Image . we dont want to load images prematurely . So we only start the async load of the image when
/// the view appears on screen. While it loads we show a placeholder image.
struct ImageView: View {
    @ObservedObject private var model = ImageViewModel()
    
    let imageURL: URL?
    
    var body: some View {
        VStack {
            if let image = model.image {
                image.resizable()
                    .scaledToFit()
            } else {
                Images.Display(image: Images.forkAndKnife)
            }
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        .onAppear {
            Task {
                await model.loadImage(url: imageURL)
            }
        }
    }
}

#Preview {
    RecipeView(recipe: .fixture())
}
