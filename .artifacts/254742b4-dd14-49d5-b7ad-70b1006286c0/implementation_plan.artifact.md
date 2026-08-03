# Implementation Plan - Consolidated Navigation Fix

The app is experiencing navigation issues due to duplicate and inconsistent `ScreenNavigation` classes (some using incorrect route strings). I will consolidate them into a single, shared singleton in the core layer to ensure stability and maintainability.

## Proposed Changes

### Core Layer (Shared Service)

#### [NEW] [screen_navigation.dart](file:///F:/commerce_app/lib/core/utils/navigation/screen_navigation.dart)
- Implement a shared `ScreenNavigation` singleton with static methods.
- Ensure all methods strictly use the `.path` property from `AppRoutes` to guarantee valid URI matching in `GoRouter`.
- Methods to include:
  - `navigateToHome()`
  - `navigateToLogin()`
  - `navigateToRegister()`
  - `navigateToForgotPassword()`
  - `navigateToVerifyCode()`
  - `navigateToResetPassword()`

---

### Cleanup & Refactoring

#### [DELETE] Duplicate Navigation Files
- Delete `lib/features/auth/view/navigation/screen_navigation.dart`
- Delete `lib/features/splash/views/navigation/screen_navigation.dart`

#### [MODIFY] Global Import Update
- Update all feature screens, widgets, and the app router to import `package:commerce_app/core/utils/navigation/screen_navigation.dart`.

## Verification Plan

### Automated Tests
- Run `dart analyze` to ensure all broken imports are fixed and no duplicate classes remain.

### Manual Verification
- Verify the full navigation flow works:
  - Splash -> Login
  - Splash -> Home (if token exists)
  - Login -> Register -> Login
  - Login -> Forgot Password -> Verify Code -> Reset Password -> Login
  - Home -> Logout -> Login
