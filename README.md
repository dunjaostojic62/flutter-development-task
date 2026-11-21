# Weather App — Flutter Development Task

A Flutter weather application built using Clean Architecture principles and BLoC state management.

The application retrieves real-time weather information and an hourly forecast using the free Open-Meteo API. Users can search for cities around the world and view weather conditions in a modern Liquid Glass interface.

## Features

- Search for weather information by city name.
- Display current temperature, weather conditions, feels-like temperature, and wind speed.
- View a 12-hour weather forecast with temperatures and weather icons.
- Refresh weather information for the selected city.
- Automatically switch between light and dark themes based on day/night information for the selected location.
- Display animated weather effects, including rain, snow, and stars during clear nights.
- Handle loading, success, and error states using BLoC.
- Responsive interface designed for web and desktop.

## Technologies and Packages

- **Flutter** — cross-platform UI framework.
- **Dart** — programming language.
- **flutter_bloc** — state management using the BLoC pattern.
- **http** — HTTP requests to external APIs.
- **Open-Meteo Forecast API** — current weather and hourly forecast data.
- **Open-Meteo Geocoding API** — city search and geographic coordinates.
- **Git and GitHub** — version control and source code hosting.

## Architecture

The application follows Clean Architecture principles, separating responsibilities into three layers:

### Presentation Layer
Contains the user interface, BLoC, events, and states.

### Domain Layer
Contains weather entities and the repository abstraction.

### Data Layer
Contains API data sources and the repository implementation responsible for converting API responses into domain entities.

Project structure:

```text
weather_app/
└── lib/
    ├── main.dart
    └── weather/
        ├── presentation/
        │   ├── bloc/
        │   ├── weather_page.dart
        │   └── weather_atmosphere.dart
        ├── domain/
        │   ├── entities/
        │   └── repositories/
        └── data/
            ├── datasources/
            └── repositories/
```

## Getting Started

### Prerequisites

- Flutter SDK installed and configured.
- Dart SDK (included with Flutter).
- VS Code or Android Studio.
- Google Chrome for running the web application.
- An internet connection for fetching weather data.

### Installation

Clone the repository:

```bash
git clone https://github.com/dunjaostojic62/flutter-development-task.git
```

Navigate to the Flutter project:

```bash
cd flutter-development-task/weather_app
```

Install dependencies:

```bash
flutter pub get
```

Run the application in Chrome:

```bash
flutter run -d chrome
```

To run on Windows, if Windows desktop support and the required build tools are configured:

```bash
flutter run -d windows
```

## How to Use

1. Launch the application.
2. The application initially loads weather information for Novi Sad.
3. Enter a city name in the search field and press Enter.
4. View current weather conditions and the hourly forecast.
5. Use the refresh button to update the selected city's weather.
6. The application adjusts its theme according to the day/night status returned by the weather API.

## Testing

Run static analysis:

```bash
flutter analyze
```

Run automated Flutter tests:

```bash
flutter test
```

### Platform Verification

| Platform | Status |
|---|---|
| Web (Chrome) | Tested |
| Windows | Tested |
| Android | Not tested — no device or emulator available |
| iOS | Not tested — requires macOS and Xcode |

Automated tests have been run successfully. The current test coverage does not establish full coverage of all application features.

## Notes and Limitations

- Internet access is required to fetch weather information.
- City searches use the first result returned by the Geocoding API, so locations with identical names may be ambiguous.
- The day/night theme updates when weather data is fetched or refreshed; it does not automatically change at the exact moment of sunrise or sunset while the app remains idle.
- Animated weather backgrounds are decorative representations of current weather conditions.

## Git Workflow

- `develop` — development and feature implementation.
- `main` — stable branch intended for tested releases.

Development work is committed to `develop` and merged into `main` after verification.

## API Documentation

- [Open-Meteo Weather Forecast API](https://open-meteo.com/en/docs)
- [Open-Meteo Geocoding API](https://open-meteo.com/en/docs/geocoding)
- [Flutter Documentation](https://docs.flutter.dev/)

## Author

Dunja Ostojić

Built as part of the Flutter Development Task.
