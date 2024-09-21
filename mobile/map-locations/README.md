# Take-Home Coding Exercise

Welcome to the coding exercise! The goal of this project is to demonstrate your skills by building an app that displays a set of locations on a map in a performant manner. Please follow the instructions below to complete the exercise.

## Project Overview

This exercise involves fetching data from a JSON file stored in this repository and implementing a map view to display locations. You'll need to implement features like filtering locations by type and displaying additional information when a location is tapped.

## Instructions

1. **Fork the Repository:**
    - Please begin by forking this repository into a private repository.
    - All of your changes should be committed to your fork.
    - Optional: Use pull requests with short descriptions to help explain as you go through

2. **Setup Project:**
    - Create an `android` or `ios` folder respectively in the root of this folder. This is where your project will live.

3. **Fetch Location Data:**
    - The repository contains a JSON file, `locations.json`, that lists various locations.
    - Use the raw file content feature of GitHub for fetching data (think of it as a mock API). Please point it to your forked repository, not the Voze repository.
        - `https://raw.githubusercontent.com/<GITHUB_ACCOUNT_NAME>/coding-exercises/master/mobile/map-locations/locations.json`
    - Your task is to parse this file and use the data within the app.

4. **Display Locations on a Map View:**
    - Create a map view in the app as the main view.
        - The data is centered around San Francisco. Please set the default location to there.
    - Plot the locations from the JSON file on the map using pins or markers.

5. **Filtering Locations:**
    - Implement a way to filter the displayed locations by `location_type`.
        - The assumption can be made the location_types are a static set and will not change.
        - You can provide a UI (e.g., dropdown menu, segmented control, etc) that allows users to select which types of locations to display on the map.
        - Please feel free to "steal" existing UI from other application such as Google Maps, Apple Maps, Zillow, etc for filtering or craft your own.
        - Optional: Distinguish between location types through the presentation of pin or markers.

6. **Additional Details on Tap:**
   - When a user taps on a location pin, show a view with more detailed information about that location.
        - Display all `attributes` inside this detail view.
        - Please feel free to "steal" existing UI from other application such as Google Maps, Apple Maps, Zillow, etc for details or craft your own.

## Requirements

- **Documentation:**
    - Please add any contextual implementation information into Implementation section at the bottom of this `README`.
    - Add code comments when relevant
    - Add information on how to get the application up and running into the Getting Started section at the bottom of this `README`.
- **Programming Language:**
    - iOS: Please focus on using Swift
    - Android: Please focus on using Kotlin (Java is still acceptable, however Kotlin is preferred)
- **Data Fetching:**
    - You may use the std library or a 3rd party library for making HTTP request.
        - If using a 3rd party library please explain why inside the Implementation section at the bottom of this `README`.
- **Map Integration:**
    - You may use any mapping library, such as MapKit
    - Please do not use a mapping library which requires an API key
- **UI/UX:**
    - Design a user-friendly interface to interact with the map and filter locations.
    - Keep it simple. This isn't a exercise to test your design skill.
- **Filtering:**
    - Implement efficient filtering of locations by their type.

## Submission

1. Once you have completed the exercise, make the repository public and email a link to the forked repository.

## Evaluation Criteria

- **Correctness:** Does the app fetch and display data correctly?
- **UI/UX:** Is the map view intuitive and easy to use (within reason given lack of design criteria)?
- **Code Quality:** Is the code clean, readable, follow modern architecture per environment, and well-structured?
- **Filtering:** Is filtering by location type implemented efficiently?
- **Attention to Detail:** Does the app show detailed information when a pin is tapped?

Feel free to reach out if you have any questions. Good luck, and happy coding!

Do not edit any lines above this line break.

---

## Getting Started

- Clone the repository
- Open `VozeMaps` in Xcode
  - note: this project was built in Xcode 16.0. Prior versions *should* work, but haven't been tested
- Hit `command` + `R` to run the project 
  

## Implementation

### UI
This app follows MVVM.
- If state is "important" it needs to live in a ViewModel.
- If state is "uninteresting" it needs to live in a View.
  - (explanation in `LocationsVM.swift`)
  - Basically, if a value is only used to drive a UI change, it doesn't need to be in a ViewModel.
  - If a value is used to make a decision, it needs to be in a ViewModel.
- ViewModels are the intermediary between Views and the rest of the app.
- Small views/components don't usually need ViewModels.

### Networking
- I didn't get around to caching.
- I'm advocate for a `Routes.swift` file, similar to backend devs.
  - iOS devs tend to spread networking code across the app and tell ourselves it scales better (it doesn't).
    - New services for each resource, or even each action on a resource.
    - In the worst cases, we split resources, endpoints and query items, etc. into complex "request builder" pipelines.
    - Increases risk for code duplication and creates a fragmented networking layer.
  - The backend practice of a unified Routes file allows for higher visibility and is plainly self documenting.

Mobile apps are networking heavy. Don't start off on the wrong foot by world building a complex networking layer or the entire app's baseline complexity will increase. It's a permanent tax.

### Models
- I keep app-wide types in the root of the Models folder.
- DTOs are in a subfolder and are usually private or nested, so they don't clutter the global namespace.

In this particular project, my instinct was to define an `Attribute` array on the `Location` struct. There's an argument that it's more "future-proof" because it can decode fields that don't exist yet.
```
struct Location: Codable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let attributes: [Attribute]
    
    struct Attribute: Codable {
        ...
    }
}
```

I decided against it. It's clear that the backend is trying to send the same 4 fields on every `Location` - even if the schema is unorthodox.
Because of that, it's better to flatten and simplify the `Location` struct. The rest of the app doesn't have to know about `Attribute`, and benefits from added simplicity.
If we need a new field in the future, we can just add it.

In other words, the extra code probably wouldn't be harmful, but it takes time to write, takes up space, and has to be maintained once it exists. "Don't solve problems you don't have!"
