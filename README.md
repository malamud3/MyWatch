# MyWatch

MyWatch is a movie and TV show catalog app built using the MVVM  architecture pattern with the addition of Controllers to handle the business logic and Managers to handle requests to third-party services used by the app. The app utilizes Firebase for two-way connection via phone number and SMS verification. Additionally, users can register/login using their Google or Apple accounts for a seamless authentication experience. 

<table>
  <tr>
    <td align="center">
      <p><strong>First Screen</strong></p>
      <p><img src="/FirstScreen.png" alt="First Screen" width="300"></p>
    </td>
    <td align="center">
      <p><strong>After User press: Tv Shows btn</strong></p>
      <p><img src="/FirstScreenTV.png" alt="First Screen TV" width="300"></p>
    </td>
    <td align="center">
      <p><strong>After User scroll down</strong></p>
      <p><img src="/ScrollDown.png" alt="Scroll Down" width="300"></p>
    </td>
    <td align="center">
      <p><strong>After User press: Category btn</strong></p>
      <p><img src="/Category.png" alt="Category" width="300"></p>
    </td>
  </tr>
  <tr>
    <td align="center">
      <p><strong>Search Screen</strong></p>
      <p><img src="/Search.png" alt="Search Screen" width="300"></p>
    </td>
    <td align="center">
      <p><strong>Search A</strong></p>
      <p><img src="/SearchA.png" alt="Search A" width="300"></p>
    </td>
    <td align="center">
      <p><strong>Search Spider Man</strong></p>
      <p><img src="/SearchSpiderMan.png" alt="Search Spider Man" width="300"></p>
    </td>
  </tr>
</table>


## Key Features

* Browse movies and TV shows in different categories, including trending, popular, recently added, and top-rated.
* Browse a "Coming Soon" section to get a sneak peek at upcoming releases.(
* Utilize a search feature to find specific movies or TV shows based on user preferences.
* Filter the displayed content by category, allowing users to quickly find content of interest.
* Includes authentication functionality using Firebase, enabling users to create accounts and securely log in.
* Provides the ability for users to save a list of their most loved movies for easy access and personalization.
* Offers additional information on each show, such as a brief summary and access to trailers via youtube.
  
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

* SDWebImage
* GoogleAPIClientForREST/YouTube
* GoogleSignIn
* GoogleSignInSwift
* FirebaseAnalytics
* FirebaseAuth
* FirebaseFirestore
* RxSwift
* RxCocoa
* SVGKit
* MaterialComponents

Make sure to use the appropriate versions of these dependencies as specified in the Podfile.

## Architecture

The MyWatch app follows the MVVM-C (Model-View-ViewModel-Controller) architecture pattern. The app's business logic is handled by controllers, while the data is managed by view models. This separation of concerns allows for better code organization and maintainability.

## Main Architectue

![Alt Text](/architecturalPattern.svg)
