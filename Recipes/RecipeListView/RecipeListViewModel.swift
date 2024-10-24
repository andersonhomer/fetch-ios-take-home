import Foundation
import Collections

/// The main view model in the app. Handles loading the recipes and updating variables for the RecipeListView
@MainActor
class RecipeListViewModel: ObservableObject {

    public enum RecipesError: Error {
        case noRecipes
        case invalidData
    }
    
 public enum RecipeListState {
        case loading
        case loaded([Recipe])
        case error(Error)
        case empty
    }
    
    @Published var state: RecipeListState = .loading
    @Published var cuisines: [String] = []
    @Published var title: String = "All Recipes"
    private var allRecipes: [Recipe] = []
    private let networking: RecipeNetworkingProtocol
    
    init(networking: RecipeNetworkingProtocol = RecipeNetworking.shared) {
        self.networking = networking
    }
    
    /// Load the recipes for the view here . Set the state with the recipes and setup all other variables for the view.
    /// We also load the cusines here for filtering in the UI.
    func loadRecipes() async {
        do {
            state = .loading
            let recipes = try await networking.fetchRecipes()
            if recipes.isEmpty {
                state = .empty
            } else {
                title = "All Recipes"
               state = .loaded(recipes)
                allRecipes = recipes
                getCuisines(recipes: recipes)
            }
        } catch {
            state = .error(error)
        }
    }
    
    /// Filter the recipes by cuisine here.
    func filterRecipes(by cuisine: String)  {
        if cuisine == "All Cuisines" {
            title = "All Recipes"
            state = .loaded(allRecipes)
            return
        }
        if case .loaded = state {
            let filteredRecipes = allRecipes.filter { $0.cuisine == cuisine }
            title = "\(cuisine) Recipes"
            state = .loaded(filteredRecipes)
        }
    }
    
    /// Load all cuisines
    /// This is a quick and dirty to get the cuisines for filtering.
    /// Ideally we would have this data returned from an endpoint.
    func getCuisines(recipes: [Recipe]) {
        let sortedCuisines = Set(recipes.map { $0.cuisine }).sorted()
        cuisines = ["All Cuisines"] + sortedCuisines
    }
}
