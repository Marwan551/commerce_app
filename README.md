# Commerce App

A Flutter portfolio project for browsing products, signing in, managing a cart and saving a wishlist. The app uses Cubit state management, REST API calls and English/Arabic localization.

This is a learning project, not a production shop. Checkout is simulated and does not process payments.

## Implemented in the source

- Product, category and brand browsing, product details and review screens.
- API-backed sign-in, registration and password-reset flows.
- Cart fetch, add, remove, quantity update and clear operations.
- Wishlist state with local SQLite persistence.
- SharedPreferences for session/preferences and English/Arabic translation assets.
- Firebase initialization and notification-related code.

## Structure

- `lib/features/`: feature-specific controllers, models and views.
- `lib/core/services/`: API client, local preferences, database and notification services.
- `lib/core/utils/`: shared widgets, validation, constants and generated asset references.
- `lib/config/`: routing and themes.

The API base URL is defined in `lib/core/services/network_service/remote/endpoints.dart`. It currently points to the external Route ecommerce API. API availability and behavior are outside this repository's control.

## Local setup

Use a Flutter SDK that includes Dart 3.12.2 or later within the Dart 3.x series, as required by `pubspec.yaml`. The tests below were checked with Flutter 3.50.1 / Dart 3.14.0 on Linux.

```sh
git clone https://github.com/Marwan551/commerce_app.git
cd commerce_app
flutter pub get
flutter analyze
flutter test
```

For an Android device or emulator, install the Android toolchain and run `flutter doctor` before `flutter run`. The Android project targets Java 17. Firebase is initialized at startup. Before connecting the app to your own backend or Firebase project, review and replace the platform configuration with configuration you control. Do not put service-account credentials or private keys in the repository.

The project uses case-sensitive package paths under `lib/core/utils/`; keep this casing consistent when adding files.

## Validation

Five model tests cover API ID mapping, optional fields, decimal prices, local favorite-data serialization and pagination metadata. Run them with:

```sh
flutter test test/product_model_test.dart
```

The unrelated generated counter test has been removed. These unit tests do not validate the full UI, authentication server, cart requests, notifications or an end-to-end purchase. Static analysis currently reports existing informational diagnostics, including Flutter API deprecations; it is not warning-free.

## Limitations

- Checkout waits briefly, reports success and clears the cart. It is not a payment integration.
- No signed release or store deployment is claimed here.
- A device launch and end-to-end API/Firebase verification remain to be done.
- The current API logger is configured to log request headers and bodies. Disable or redact it before entering real credentials or using production data.
- Screenshots and a recorded walkthrough are not included yet.
