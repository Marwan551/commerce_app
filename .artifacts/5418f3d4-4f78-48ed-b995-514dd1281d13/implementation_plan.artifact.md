# Task 10: Integrate Firebase Cloud Messaging (FCM) for Push Notifications

This plan outlines the steps to integrate FCM for push notifications, including foreground handling with local notifications and background/terminated state handling.

## User Review Required

> [!IMPORTANT]
> - `google-services.json` and `GoogleService-Info.plist` are missing. These files MUST be added to the project for Firebase to function.
> - The Firestore collection and document structure for saving tokens needs to be defined. I will assume a `users` collection and use the device token as a document ID or part of a document for now.

## Proposed Changes

### Configuration

#### [MODIFY] [pubspec.yaml](file:///F:/commerce_app_2/pubspec.yaml)
- Add `firebase_core`, `firebase_messaging`, and `cloud_firestore` dependencies.

#### [MODIFY] [android/settings.gradle.kts](file:///F:/commerce_app_2/android/settings.gradle.kts)
- Add Google Services plugin.

#### [MODIFY] [android/app/build.gradle.kts](file:///F:/commerce_app_2/android/app/build.gradle.kts)
- Apply Google Services plugin.

#### [MODIFY] [android/app/src/main/AndroidManifest.xml](file:///F:/commerce_app_2/android/app/src/main/AndroidManifest.xml)
- Add intent filter for background notification handling if needed (usually handled by FCM automatically).

### FCM Service Implementation

#### [NEW] [fcm_service.dart](file:///F:/commerce_app_2/lib/core/services/notifications/fcm_service.dart)
- Implement `FcmService` class:
    - `init()`: Initialize Firebase and FCM.
    - `requestPermission()`: Handle Authorized, Provisional, Denied states.
    - `getToken()`: Retrieve and print device token.
    - `saveTokenToFirestore()`: Persist token in Firestore.
    - `initForegroundNotifications()`: Configure `flutter_local_notifications` for foreground messages.
    - `listenToMessages()`: Listen to `onMessage`, `onMessageOpenedApp`, and handle initial message.

### Integration

#### [MODIFY] [main.dart](file:///F:/commerce_app_2/lib/main.dart)
- Initialize Firebase.
- Initialize `FcmService`.

## Verification Plan

### Automated Tests
- Not applicable for push notification integration easily without mock environments.

### Manual Verification
1. Verify Firebase initialization in logs.
2. Check for notification permission prompt on app start.
3. Verify FCM token is printed in the console.
4. Verify token is saved to Firestore (after adding config files).
5. Send a test message from Firebase Console while app is in foreground and verify local notification display.
6. Send a test message while app is in background/terminated and verify it appears in system tray and opens the app on tap.
