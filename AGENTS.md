# Repository Guidelines

## Build, Test, and Development Commands
- Install deps: `flutter pub get`
- Generate code (Floor): `dart run build_runner build --delete-conflicting-outputs`
- Generate l10n: `flutter gen-l10n`
- Analyze & format: `flutter analyze` and `dart format .`
- Run app: `flutter run -d macos` or `flutter run -d android`
- Build release: `flutter build apk` (Android), `flutter build macos`
- Tests: `flutter test` (add tests under `test/`)

## Coding Style & Naming Conventions
- Dart 3 with `flutter_lints`; key rules: single quotes, trailing commas, sort constructors first, use super parameters, no leading underscores for locals, strict casts/inference.
- Indentation: 2 spaces. Files: `snake_case.dart`. Classes: `PascalCase`. Members/variables: `lowerCamelCase`.
- Keep widgets small and composable; add keys to stateful elements.

## Testing Guidelines
- Framework: `flutter_test`. Place tests in `test/` and name like `feature_name_test.dart`.
- Prefer unit tests for logic (e.g., parsers, DB mappers) and widget tests for UI.
- Run locally with `flutter test`. Optional coverage: `flutter test --coverage`.

## Commit & Pull Request Guidelines
- Commits: short, imperative summaries (e.g., "fix: handle empty pass list"). Reference issues/PRs when relevant (e.g., `(#123)`).
- PRs: include clear description, linked issue, platform notes (Android/macOS), and screenshots/GIFs for UI changes.
- Before opening a PR: run `flutter analyze`, `dart format .`, regenerate code (`build_runner`, `gen-l10n`), and ensure the app runs on at least one target.
- Generated files: commit Floor and l10n outputs (`lib/db/*.g.dart`, `lib/l10n/app_localizations.dart`).

## Localization & Data Generation
- Add strings to ARB files in `lib/l10n/` (do not inline user-facing text).
- DO NOT touch generated files, like those ending in `*.g.dart` or those in the `lib/l10n/` folder
- After editing ARB: `flutter gen-l10n`.
- After editing entities/DAOs: `dart run build_runner build --delete-conflicting-outputs`.

## Security & Configuration Tips
- Do not commit secrets. Keep `dependency_overrides` (local `passkit`/`passkit_ui`) aligned to your workspace paths.
- Use Flutter `3.22.x` (see `pubspec.yaml`) to avoid toolchain drift.
