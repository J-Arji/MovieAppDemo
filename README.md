# Movie App


## Description
In this app, you can search for the movie you want and view its details.

## Features
- Search and display the list of movies you want 🍿.
- Display detailed movie information 🍿.




## Getting started

1. Clone the project.
2. Go to the repo folder.
3. Open the MovieApp.xcodeproj file.
4. Wait for SPM to fetch all dependencies.
5. generate an API key from The Movie Database ([TMDB](https://developer.themoviedb.org/docs/getting-started)).
6. Save the API key as API_KEY in the Config.xcconfig file.
8. Run the app using Command + R.
9. Good luck 🎉


### Requirements

- iOS 15.0+ 
- Xcode 15.x
- Swift 5.x


> **Note**
> You must be registered on the [TMDB](https://www.themoviedb.org/signup) site before generating the API key.
> The app will not work without an API key




## Structure
- Presenter: It contains all User interface application code
- Domain: Contains business logic and doesn’t depend on any other layer.
- Data: Gets data from remote or local data sources and depend domain layer
- App: It contains the Dependency Injection Container & the Environment.

Presentation Layer & Data Layer both depend on Domain Layer
Presentation Layer & Data Layer don’t depend on each other
App Layer depends on all of them





## Support:  
### 🌎 Multi-Language Support
This project supports multiple languages.
- [English]
- [Persian]

  
### Dark and Light Mode
"Product menu > Scheme > Edit Scheme".
You can change the language that your app will launch by choosing it from the "App Language" option




## Dependency
It uses SPM for dependency management and you do not need to install the other third-party management ([Swift Package Manager](https://github.com/apple/swift-package-manager))
- [SimpleKeychain](https://github.com/auth0/SimpleKeychain) : It is a utility for securely storing sensitive data, such as passwords, tokens, or API keys, in the iOS Keychain.
- [FActory](https://github.com/hmlongco/Factory) :  Factory is A new approach to Container-Based Dependency Injection for Swift
    - ✅ Compile-time safety
    - ✅ Laziness
    - ✅ Control the lifecycle/scope
          - Factory provides us with 5 scopes: Singleton, Cached, Shared, Graph, Unique.
    - ✅ Using mocks for testing is so easy
 




## Feedback

### Contributing
 Feedback, suggestions, and contributions are welcome. Please use GitHub issues.

 ## Author
 Javad arji ([j.arji](javad.ar2000ir@gmail.com))








