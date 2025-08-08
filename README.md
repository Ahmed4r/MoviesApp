# MoviesApp

A Flutter application for browsing and discovering movies, with features like trending movies, new releases, and a watchlist. The app uses The Movie Database (TMDB) API for movie data and Firebase Firestore for managing user watchlists.

## 📱 Features

- 🎬 Browse trending movies
- 🆕 Discover new releases
- 🔍 Search for movies
- ❤️ Add movies to watchlist
- 📱 Responsive UI with smooth animations
- 🔄 Real-time sync with Firestore
- 🌐 Online/Offline support

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: Provider & Bloc
- **Backend**: Firebase Firestore
- **API**: The Movie Database (TMDB)
- **Dependency Injection**: GetIt
- **Localization**: Easy Localization
- **Networking**: Dio
- **Image Loading**: Cached Network Image
- **Routing**: Go Router

## 🖼️ Screenshots

| Home Screen | Movie Details | Watchlist |
|-------------|---------------|------------|
| ![Home Screen]("C:\Users\ahmed\porfilo\movies.png") | ![Movie Details](assets/movie.png) | ![Watchlist](assets/Dora.jpg) |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Firebase project setup
- TMDB API key

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/MoviesApp.git
   cd MoviesApp
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android/iOS app to Firebase
   - Download and add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to iOS project

4. Add TMDB API key:
   - Create a `.env` file in the root directory
   - Add your TMDB API key:
     ```
     TMDB_API_KEY=your_api_key_here
     ```

5. Run the app:
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── Presentation/         # UI Layer
│   ├── Screens/         # App screens
│   └── Widgets/         # Reusable widgets
├── data/                # Data Layer
│   ├── api/             # API clients
│   └── FireStore/       # Firestore services
├── model/               # Data models
└── provider/            # State management
```

## 🔄 State Management

The app uses a combination of:
- **Provider** for dependency injection
- **BLoC** for complex state management
- **Firestore** for real-time data sync



## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for the movie data
- [Flutter](https://flutter.dev/) for the amazing framework
- [Firebase](https://firebase.google.com/) for backend services

## 🤝 Contributing

Contributions are always welcome! Please feel free to submit a Pull Request.
