# MyWatch

MyWatch is a movie and TV show catalog app built using the MVVM (Model-View-ViewModel) architecture pattern with the addition of Controllers to handle the business logic and Managers to handle requests to third-party services used by the app. 

### First Screen
![Alt Text](/FirstScreen.png)

### After User press: Tv Shows btn
![Alt Text](/FirstScreenTV.png)

### After User scroll down
![Alt Text](/ScrollDown.png)

### After User press: Category btn
![Alt Text](/Category.png)


### Search Screen
![Alt Text](/Search.png)

### Search A
![Alt Text](/SearchA.png)

### Search Spider Man
![Alt Text](/SearchSpiderMan.png)


## Key Features

* Browse movies and TV shows in different categories, including trending, popular, recently added, and top-rated.
* Access a "Coming Soon" section to get a sneak peek at upcoming releases.
* Utilize a search feature to find specific movies or TV shows based on user preferences.
* Filter the displayed content by category, allowing users to quickly find content of interest.
* Implements the RxSwift framework for reactive programming and asynchronous data handling.
* Includes authentication functionality using Firebase, enabling users to create accounts and securely log in.
* Provides the ability for users to save a list of their most loved movies for easy access and personalization.
* Offers additional information on each show, such as a brief summary and access to trailers.
  
## Installation
To install the MyWatch app, follow these steps:

Clone the repository from GitHub.
Open the project in Xcode.
Ensure that the required dependencies are installed using CocoaPods. Run the following command in the terminal:
Copy code
pod install
Build and run the app on an iOS device or simulator running a compatible version of iOS.

## Dependencies
The MyWatch app relies on the following dependencies:

SDWebImage
GoogleAPIClientForREST/YouTube
GoogleSignIn
GoogleSignInSwift
FirebaseAnalytics
FirebaseAuth
FirebaseFirestore
RxSwift
RxCocoa
SVGKit
MaterialComponents
Make sure to use the appropriate versions of these dependencies as specified in the Podfile.

## Architecture

The MyWatch app follows the MVVM (Model-View-ViewModel) architecture pattern. The app's business logic is handled by controllers, while the data is managed by view models. This separation of concerns allows for better code organization and maintainability.

## Main Architectue

![Alt Text](/architecturalPattern.svg)
