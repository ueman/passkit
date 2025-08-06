# Gemini Workspace

This document provides instructions and guidelines for working with the PassKit App project.

## Project Overview

This project is a Flutter application for managing PassKit files. It allows users to import, view, and manage their passes. It's available on Android and macOS.

## Key Technologies

*   **Flutter:** The UI toolkit used to build the application.
*   **Dart:** The programming language used to write the application.
*   **Floor:** A persistence library for SQLite databases.
*   **PassKit:** A library for working with PassKit files.

## Project Structure

The project is structured as follows:

*   `lib/`: Contains the main application code.
    *   `db/`: Contains the database-related code.
    *   `home/`: Contains the home page of the application.
    *   `import_pass/`: Contains the logic for importing passes.
    *   `pass_backside/`: Contains the UI for the back of a pass.
    *   `settings/`: Contains the settings page.
    *   `web_service/`: Contains code for interacting with web services.
    *   `widgets/`: Contains reusable widgets.
*   `assets/`: Contains the application's assets, such as images and fonts.
*   `test/`: Contains the application's tests.

## Available Commands

The following commands are available for this project:

*   `flutter pub get`: Installs the project's dependencies.
*   `flutter run`: Runs the application.
*   `flutter test`: Runs the project's tests.
*   `flutter build apk`: Builds an Android APK.

# Translations

* Do not add texts directly in the source code
* Add translations to the arb files
* After adding new translations make sure to run `flutter gen-l10n`
