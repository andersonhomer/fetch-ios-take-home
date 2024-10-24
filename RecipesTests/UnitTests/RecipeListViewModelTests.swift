import XCTest

@MainActor
final class RecipeListViewModelTests: XCTestCase {

    var viewModel: RecipeListViewModel!
    var fakeRecipeNetworking: FakeRecipeNetworking!
    var expectedRecipes : [Recipe] = [
        .fixture(),
        .fixture(cuisine:"Italian", name: "Dish2", id: UUID()),
        .fixture(cuisine: "Greek", name: "Dish3", id: UUID()),
        .fixture(cuisine: "French", name: "Dish4", id: UUID())
    ]

    override func setUp() {
        super.setUp()
        
        fakeRecipeNetworking = FakeRecipeNetworking()
        viewModel = RecipeListViewModel(networking: fakeRecipeNetworking)
       
    }

    override func tearDown() {
        viewModel = nil
        fakeRecipeNetworking = nil
        super.tearDown()
    }

    func testLoadRecipes_SuccessfullyLoadsRecipesTitleAndCuisines() async {
    
        fakeRecipeNetworking.recipes = expectedRecipes

        await viewModel.loadRecipes()

        if case .loaded(let recipes) = viewModel.state {
            XCTAssertEqual(recipes, expectedRecipes)
        } else {
            XCTFail("State should be loaded with recipes")
        }
        XCTAssertEqual(viewModel.title, "All Recipes")
        XCTAssertEqual(viewModel.cuisines, ["All Cuisines", "American", "French", "Greek", "Italian"])
    }

    
    func testLoadRecipes_Empty_SetsCorrectState() async {
      
        fakeRecipeNetworking.recipes = []

        await viewModel.loadRecipes()

        if case .empty = viewModel.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("State should be empty")
        }
    }

    func testLoadRecipes_Error_ReturnsError() async {
        
        fakeRecipeNetworking.shouldReturnError = true

        await viewModel.loadRecipes()

        if case .error = viewModel.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("State should be error")
        }
    }

  
    func testFilterRecipes_ByCuisine() async {
      
        fakeRecipeNetworking.recipes = expectedRecipes
        await viewModel.loadRecipes()

        viewModel.filterRecipes(by: "Italian")

        if case .loaded(let filteredRecipes) = viewModel.state {
            XCTAssertEqual(filteredRecipes.count, 1)
            XCTAssertEqual(filteredRecipes.first?.name, "Dish2")
        } else {
            XCTFail("State should be loaded with filtered recipes")
        }
        XCTAssertEqual(viewModel.title, "Italian Recipes")
    }

    func testFilterRecipes_AllCuisines() async {
      
        fakeRecipeNetworking.recipes = expectedRecipes
        await viewModel.loadRecipes()

        viewModel.filterRecipes(by: "All Cuisines")

        if case .loaded(let filteredRecipes) = viewModel.state {
            XCTAssertEqual(filteredRecipes.count, 4)
        } else {
            XCTFail("State should be loaded with all recipes")
        }
        XCTAssertEqual(viewModel.title, "All Recipes")
    }
}
