# Movie App


# Description
In this app, you can search for the movie you want and view its details.

## Features
- Search and display the list of movies you want 🍿.
- Display detailed movie information 🍿.




# Getting started

1. Clone the project.
2. Go to the repo folder.
3. Open the MovieApp.xcodeproj file.
4. Wait for SPM to fetch all dependencies.
5. Register and generate an API key from The Movie Database ([TMDB](https://developer.themoviedb.org/docs/getting-started)).
6. Save the API key as API_KEY in the Config.xcconfig file.
7. Run the app using Command + R.
8. Good luck 🎉



# Structure
- Presenter: It contains all User interface application code
- Domain: Contains business logic and doesn’t depend on any other layer.
- Data: Gets data from remote or local data sources and depend domain layer
- App: It contains the Dependency Injection Container & the Environment.

Presentation Layer & Data Layer both depend on Domain Layer
Presentation Layer & Data Layer don’t depend on each other
App Layer depends on all of them






