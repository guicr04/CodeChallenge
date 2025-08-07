# CatApp  

CatApp is an iOS application developed in Swift that integrates with TheCatAPI to display a list of cat breeds, view detailed information, and manage favorites.
The project follows modern iOS development best practices, including MVVM architecture, dependency injection, and unit/UI testing.

---

## Table of Contents  
- [Problem Description](#problem-description)  
- [Solution](#solution)  
- [Prerequisites](#prerequisites)  
- [Installation](#installation)  
- [Usage](#usage)  
- [Technical Details](#technical-details)  
- [Possible Improvements](#possible-improvements)  

---

## Problem Description  

The challenge was to create an iOS application that consumes TheCatAPI to:  
- Display a list of cat breeds with images  
- Allow marking/unmarking favorites  
- Explore breed details  
- Search for breeds

---

## Solution  

CatApp implements:  
- Integration with TheCatAPI to fetch breeds and their details (name, description, temperament, origin, and image)  
- Paginated breed list with incremental loading  
- Detail screen with image, information, and favorite toggle button  
- Favorites management with persistent storage
- A dedicated favorites tab displaying only marked breeds
- Removal of favorites directly from the detail screen
- Accessibility identifiers to improve test automation
- Modern SwiftUI design and architecture 

---

## Prerequisites  
- iOS device or simulator (iOS 15.0+)  
- Xcode 13.0+  
- TheCatAPI key  

## Installation  

Clone the repository and open it in Xcode:

```bash

# Clone repository
git clone https://github.com/guicr04/CodeChallenge.git

# Open in Xcode
open CatApp.xcodeproj
```

---

## Usage
- On launch, the app automatically loads a paginated list of cat breeds.
- Tap a breed item to open the BreedDetailSheet.
- Inside the detail view, tap the star (favorite button) to toggle favorite status.
- Access the Favorites tab to see only your marked breeds.
- Favorites can also be removed directly from the detail screen.

---

## Technical Details

### Core Technologies

- Language: Swift
- UI: SwiftUI (declarative)
- Architecture: MVVM
- Networking: URLSession + JSON parsing
- Images: AsyncImage for async loading
- Pagination: Incremental loading

### Key Features

- Persistent favorites (UserDefaults)
- Accessibility identifiers for testability
- Dependency injection for test mocking
- Modular code organization (Models, ViewModels, Views, Services)
- Modern concurrency (async/await where possible)

### Testing
 
- Unit tests with XCTest (models, services, and view models)
- Coverage includes main flows like pagination, favorites, and detail viewing


---

## Possible Improvements

- Search and filter by breed attributes
- Improved image caching
- Onboarding for first-time users
- Enhanced UI/UX with animations, themes, and customization
- Internationalization (multiple languages)