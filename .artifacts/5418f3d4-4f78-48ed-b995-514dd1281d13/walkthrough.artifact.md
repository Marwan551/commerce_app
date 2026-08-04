# Walkthrough - Forgot Password Flow & Architectural Adjustments

I have implemented the complete Forgot Password flow and refactored core services following the new architectural guidelines.

## Changes Made

### Core & Services
- **Singletons**: Refactored `Endpoints`, `SharedPrefHelper`, and `LocalNotificationService` to follow the Singleton pattern.
- **Shared Preferences**: Added `SharedPrefKeys` and implemented `jsonEncode`/`jsonDecode` for handling full data models (User model).
- **Toastification**: Consolidated `AppToast` into a single `show` function using `ToastificationType`.
- **Validation**: Extracted all validation logic into a dedicated `AppValidator` class.
- **Loading UI**: Updated `AppLoadingIndicator` to use a Lottie animation (`Loading.json`).
- **Notification Service**: Enhanced initialization to explicitly create the Android notification channel and safely handle permissions.

### Navigation
- **Feature-Specific Navigation**: Created `SplashNavigation` and `AuthNavigation` to decouple feature logic from the global router.
- **Route Parameters**: Updated `AppRouter` and `ScreenNavigation` to pass the `email` argument through the Forgot Password flow using GoRouter's `extra` parameter.

### Splash Feature
- **SplashCubit**: Refactored to use a single callback `onFinished(bool isAuthenticated)` and updated it to decode the full User model from local storage.

### Auth Feature (Forgot Password, Login, Register)
- **Cubit Refactoring**:
    - Moved `TextEditingController`s and `GlobalKey<FormState>` into the Cubits (`LoginCubit`, `RegisterCubit`, `ForgotPasswordCubit`).
    - Implemented validation logic within Cubits.
    - Replaced string-based status matching (`== 'success'`) with HTTP status code checks and model property validation.
- **View Refactoring**:
    - Converted View Bodies to `StatelessWidget`s.
    - Replaced `BlocBuilder`/`BlocListener` with `BlocConsumer` where appropriate.
    - Implemented `onChanged` validation for real-time feedback.
- **OTP UI**: Integrated the `pinput` package for a superior 6-digit code entry experience.
- **Success UI**: Updated `SuccessDialog` to use Figma-provided SVG images instead of standard Material icons.

## Verification Results

### Manual Verification
- **Flow**: Verified Email -> OTP -> Reset Password flow end-to-end.
- **Data Persistence**: Confirmed email is correctly passed to subsequent screens without placeholders.
- **Notifications**: Local notification triggers successfully on the first step of the forgot password flow.
- **Validation**: Form buttons and fields react correctly to validation state changes.
- **UI Consistency**: Themes and styles are now correctly applied using `Theme.of(context)`.

> [!TIP]
> The `pinput` package has been added to `pubspec.yaml`. Ensure you run `flutter pub get` before building the app.
