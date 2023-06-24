# MyWatch

MyWatch is a movie and TV show catalog app built using the MVVM (Model-View-ViewModel) architecture pattern with the addition of Controllers to handle the business logic and Managers to handle requests to third-party services used by the app. 

<table>
  <tr>
    <td align="center">
      <strong>First Screen</strong>
      <br>
      <img src="/FirstScreen.png" alt="First Screen" width="300">
    </td>
    <td align="center">
      <strong>After User press: Tv Shows btn</strong>
      <br>
      <img src="/FirstScreenTV.png" alt="First Screen TV" width="300">
    </td>
    <td align="center">
      <strong>After User scroll down</strong>
      <br>
      <img src="/ScrollDown.png" alt="Scroll Down" width="300">
    </td>
  </tr>
  <tr>
    <td align="center">
      <strong>After User press: Category btn</strong>
      <br>
      <img src="/Category.png" alt="Category" width="300">
    </td>
    <td align="center">
      <strong>Search Screen</strong>
      <br>
      <img src="/Search.png" alt="Search Screen" width="300">
    </td>
    <td align="center">
      <strong>Search A</strong>
      <br>
      <img src="/SearchA.png" alt="Search A" width="300">
    </td>
  </tr>
  <tr>
    <td colspan="3" align="center">
      <strong>Search Spider Man</strong>
      <br>
      <img src="/SearchSpiderMan.png" alt="Search Spider Man" width="300">
    </td>
  </tr>
</table>


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
