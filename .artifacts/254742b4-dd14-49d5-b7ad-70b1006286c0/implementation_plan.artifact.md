# Implementation Plan - Fix Routing and UI Errors

Fix the critical errors in routing configuration and splash screen UI that are preventing the app from running correctly.

## Proposed Changes

### Configuration & Routing

#### [MODIFY] [routes_enums.dart](file:///F:/commerce_app/lib/config/routing/routes_enums.dart)
- Restore the `path` property to the `AppRoutes` enum.
- Ensure all paths start with `/` (e.g., `/splash`, `/home`, `/login`).

#### [MODIFY] [app_router.dart](file:///F:/commerce_app/lib/config/routing/app_router.dart)
- Use `AppRoutes.splash.path` for the initial location and route path.
- Add missing routes for `home` and `login`.

### Features: Splash

#### [MODIFY] [screen_navigation.dart](file:///F:/commerce_app/lib/features/splash/views/navigation/screen_navigation.dart)
- Fix the navigation logic to use `AppRoutes.home.path` and `AppRoutes.login.path` instead of invalid casts.

#### [MODIFY] [splash_screen.dart](file:///F:/commerce_app/lib/features/splash/views/screens/splash_screen.dart)
- Fix the `LoadingAnimation` widget call (it was being called as a function `loading()`).
- Correct the import and usage of the `LoadingAnimation` widget.

## Verification Plan

### Automated Tests
- Verify code compiles without errors.
- Check for any lint warnings in the modified files.

### Manual Verification
- Run the app and verify the splash screen shows correctly.
- Verify navigation to the home screen occurs after 3 seconds.
