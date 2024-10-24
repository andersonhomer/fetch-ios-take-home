import SwiftUI

struct RecipesListView: View {
    @ObservedObject private var model = RecipeListViewModel()
    @State private var showTopSheet: Bool = false
    @State private var selectedRecipe: String = ""
    
    var body: some View {
        NavigationStack {
            switch model.state {
            case .loading:
                loadingView
                
            case .loaded(let recipes):
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            recipeViews(recipes: recipes)
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    }
                    .id("top")
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                TitleText(text: model.title)
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu {
                                Picker("Cuisine", selection: $selectedRecipe) {
                                    ForEach(Array(model.cuisines), id: \.self) { cuisine in
                                        Text(cuisine)
                                    }
                                }
                            } label: {
                                Images.Icons.ToolBarIcons(image: Images.filterIcon)
                            }
                            .onChange(of: selectedRecipe) {_, newValue in
                                model.filterRecipes(by: newValue)
                                scrollProxy.scrollTo("top", anchor: .top)
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                Task {
                                    await model.loadRecipes()
                                    scrollProxy.scrollTo("top", anchor: .top)
                                }
                            }) {
                                Images.Icons.ToolBarIcons(image: Images.refreshIcon)
                            }
                        }
                    }
                    
                }.background(Branding.gradient)
           
            case .error:
                errorView
                
            case .empty:
                emptyRecipesView
            }
             
        }
        .task {
            await model.loadRecipes()
        }
    }
    
    @ViewBuilder
    private var emptyRecipesView: some View {
        VStack(alignment: .center){
            Images.Display(image: Images.forkAndKnife , variant: .multi)
            BodyText(text: "We couldn't find any recipes.")
        }
        .padding()
    }
    
    @ViewBuilder
    private var errorView: some View {
        VStack(alignment: .center){
            Images.Display(image: Images.error , variant: .multi)
            BodyText(text: "We encountered an error loading the recipes. Please try again later.")
        }
        .padding()
    }
    
    @ViewBuilder
    private var loadingView: some View {
        ProgressView("loading...")
    }
    
    @ViewBuilder
    private func recipeViews(recipes: [Recipe]) -> some View {
        ForEach(recipes) { recipe in
            RecipeView(recipe: recipe)
                .id(recipe.id)
        }
    }
    
}

#Preview {
    RecipesListView()
}
