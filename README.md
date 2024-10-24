### Steps to Run the App

The app requires nothing out of the ordinary to run. Once the project is downloaded it can be run from Xcode.
Im using Xcode 16.0 And the app iOS target is iOS 18.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized architecture and UI/UX in the project. I tried my best to have clear separation of logic , data , and UI. 
I intentionally used the protocol paradigm with dependency injection so that I could properly unit test all the logic in the application.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent about 6 hours working on this project. I spent about 4.5 hours building the app and the next 1.5 hours writing unit tests and creating the mocks for the unit tests.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I probably could have added more UI elements but focused on spreading my time around architecture , design and testing .
Initially I wanted to simulate paging , so that we only load subsets of the data at a time . But that is usually better when supported by the backend. Instead to limit network usage. I only load an Image when the view containing it appears . That way we dont load all the images for all the recipes when the app is launched. Only as you scroll would an image load.

### Weakest Part of the Project: What do you think is the weakest part of your project?

Total UI elements - I just show the image , name and cusisine for each recipe . Maybe if I had more time i could have done more there.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

The only additional library I used was Swift Collections.
The UI Branding code is personal code that I reuse across my projects. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

The main contraint for me was the fact that the app was limited to one screen. So I kept the UI clean and simple in that regard. I added the ability to filter the recipes by Cuisine
in addition to the required ability to refresh the recipes. I also added dark mode support utiizing the Asset Catalog in the app.


