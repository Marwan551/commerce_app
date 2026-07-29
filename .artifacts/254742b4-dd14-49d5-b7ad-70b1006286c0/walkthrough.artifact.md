# Walkthrough - Routing Fix for "Page Not Found"

I have corrected the routing configuration to fix the `GoException: no routes for location: /splash` error.

## Changes Made

### Configuration & Routing
- **[routes_enums.dart](file:///F:/commerce_app/lib/config/routing/routes_enums.dart)**: Restored the `path` property to the `AppRoutes` enum. This ensures all routes have valid URI paths (starting with `/`) which is required by GoRouter.
  - `home`: `/`
  - `login`: `/login`
  - `splash`: `/splash`
- **[app_router.dart](file:///F:/commerce_app/lib/config/routing/app_router.dart)**:
  - Updated the router to use `AppRoutes.splash.path` for both the `initialLocation` and the route path.
  - Added the missing `home` and `login` routes to the router so navigation targets exist.

### Features: Splash
- **[screen_navigation.dart](file:///F:/commerce_app/lib/features/splash/views/navigation/screen_navigation.dart)**: Updated the singleton navigation methods to use the `.path` property of the enum instead of the `.name` property.

## Verification Results
- **Route Matching**: The initial location `/splash` now matches the registered route path exactly.
- **Navigation**: The timer in `SplashScreen` will now correctly trigger `ScreenNavigation.navigateToHome()`, which points to the `/` route registered in the router.
