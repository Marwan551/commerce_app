# Implementation Plan - Fix "Page Not Found" Routing Error

The app is failing with `GoException: no routes for location: /splash` because the routes are registered using `Enum.name` (e.g., `"splash"`), but GoRouter expects absolute paths (e.g., `"/splash"`) for top-level routes.

## User Review Required

> [!IMPORTANT]
> I will restore the `path` property to the `AppRoutes` enum. This is the best practice for ensuring type-safe, valid URI paths across the application.

## Proposed Changes

### Configuration & Routing

#### [MODIFY] [routes_enums.dart](file:///F:/commerce_app/lib/config/routing/routes_enums.dart)
- Restore the `path` property to the enum.
- Define valid paths for all routes:
  - `home`: `/`
  - `login`: `/login`
  - `splash`: `/splash`

#### [MODIFY] [app_router.dart](file:///F:/commerce_app/lib/config/routing/app_router.dart)
- Update `initialLocation` to use `AppRoutes.splash.path`.
- Update the `GoRoute` path to use `AppRoutes.splash.path`.
- Restore the `home` and `login` routes so navigation targets exist.

---

### Features: Splash

#### [MODIFY] [screen_navigation.dart](file:///F:/commerce_app/lib/features/splash/views/navigation/screen_navigation.dart)
- Update navigation methods to use `.path` instead of `.name`.

---

## Verification Plan

### Automated Tests
- Verify the code compiles without errors.

### Manual Verification
- Run the app and confirm the splash screen appears (no "Page Not Found" error).
- Confirm that navigation to Home/Login works after the splash timer.
