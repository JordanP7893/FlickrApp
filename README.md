# FlickrApp

## Overview

**FlickrApp** makes use of the Flickr API to display a list of popular photos from the service. Users can tap on photos view detailed information and location data for each photo and explore more photos by specific users.

![](https://github.com/JordanP7893/FlickrApp/blob/main/demo.gif)

## Features

- **Display Popular Photos:** Fetch and display a list of popular photos from the Flickr API.
- **Photo Details:** View more information about each photo, including tags and a mpa view with the location the photo was taken.
- **User Photos:** Explore more photos by a specific users in an Instagram style view.

## Architecture

### MVVM (Model-View-ViewModel)

- **Separation of Concerns:** MVVM helps to split the different parts of the app into clear responsibilities, enhancing code maintainability and scalability.
- **Testability:** Creating a seperate view model to handle logic allows unit tests of specific business logic to be more easily written.

### Protocols

- **Testability:** The use of protocols makes the code more modular and easier to test. This is crucial for maintaining a high-quality codebase.
- **Xcode Previews:** Protocols also facilitate the use of Xcode previews, allowing for faster and more efficient UI development.
