# APOD
# Requirement 
Create an app which uses the NASA APOD API (https://github.com/nasa/apod-api).
Basic Features:
	•	On launch of the app it should load the date, title, image and the explanation for the current day's APOD (Astronomy Picture of the Day). On some days the image is replaced by an embedded video. The app should handle this scenario as well. (Example 11th October 2021 APOD)
	•	Allow the user to load the NASA APOD for any day that they want. 
	•	Last service call including image should be cached and loaded if any subsequent service call fails.

## Building and running the project (requirements).
* Swift 5.4+
* Xcode 12.3+
* iOS 14.0+

## Setup Configs
- Checkout main branch to run latest version
- Open the terminal.
- Navigate to the project root directory.
- Open the project by double clicking the `APOD.xcodeproj` file
- Select the build scheme which can be found right after the stop button on the top left of the IDE
- [Command(cmd)] + R - Run app

## Assumptions
- On launch, APOD is loaded for today. If for the day APOD details are unavailable or any error occurs, User can request for another day using "Select Date" button provided.
- If any future API calls fail, last API result is returned unless first launch.
- If media type is Video, user is redirected to browser when user taps on play link.
- MVVM used for architecture. 


## Improvements required
 * UI can be more polished
 * Image Loader needs to be optimised
 * UI Unit test cases support
 * Support for landscape
