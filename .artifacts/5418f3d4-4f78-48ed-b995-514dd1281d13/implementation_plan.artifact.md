# Implementation Plan - Forgot Password Flow & Local Notification Service (Revised)

Implement the Forgot Password flow and Local Notification Service with specific architectural adjustments as requested.

## User Review Required

> [!IMPORTANT]
> - **Dependency Addition**: I will add `pinput` to `pubspec.yaml` for the OTP verification UI.
> - **Cubit Controllers**: `TextEditingController`s will be moved from Widgets to Cubits.
> - **Singletons**: `Endpoints` and `SharedPrefHelper` will be refactored to singletons.
> - **Navigation**: Each feature (e.g., Auth) will have its own navigation class.

## Proposed Changes

### Core Layer Refactoring

#### [MODIFY] [endpoints.dart](file:///F:/commerce_app_2/lib/core/services/remote/endpoints.dart)
- Convert to Singleton pattern.
- Update usages to use `Endpoints().baseUrl` instead of `Endpoints.baseUrl`.

#### [MODIFY] [shared_pref_service.dart](file:///F:/commerce_app_2/lib/core/services/network_service/local/shared_pref_service.dart)
- Convert to Singleton pattern.
- Add `SharedPrefKeys` class with constants.
- Use `jsonEncode`/`jsonDecode` for full data models (User model).

#### [MODIFY] [app_toast.dart](file:///F:/commerce_app_2/lib/core/utils/widgets/toast/app_toast.dart)
- Consolidate into a single `show` function with a `ToastificationType` parameter.

#### [NEW] [app_validator.dart](file:///F:/commerce_app_2/lib/core/utils/validation/app_validator.dart)
- Extract validation logic from `CustomTextField` into a separate file.

#### [MODIFY] [app_loading_indicator.dart](file:///F:/commerce_app_2/lib/core/utils/widgets/loading/app_loading_indicator.dart)
- Update to use the Lottie loading animation from assets.

---

### Splash Feature

#### [MODIFY] [splash_cubit.dart](file:///F:/commerce_app_2/lib/features/splash/controllers/cubit/splash_cubit.dart)
- Update `startTimer` to use a single callback `void Function(bool isAuthenticated)`.
- Use the full data model from `SharedPrefHelper`.

---

### Auth Feature & Navigation

#### [NEW] [auth_navigation.dart](file:///F:/commerce_app_2/lib/features/auth/auth_navigation.dart)
- Feature-specific navigation class for Auth flow.

#### [MODIFY] [app_router.dart](file:///F:/commerce_app_2/lib/config/routing/app_router.dart)
- Update routes to accept `email` as an argument (passing via `extra`).

#### [MODIFY] [forgot_password_cubit.dart](file:///F:/commerce_app_2/lib/features/auth/controllers/cubit/forgot_password/forgot_password_cubit.dart)
- Add `emailController`, `otpController`, `passwordController`, and `confirmPasswordController`.
- Implement validation logic that emits state changes for button enablement.

#### [MODIFY] [forgot_password_screen.dart](file:///F:/commerce_app_2/lib/features/auth/view/screens/forgotPassword/forgot_password_screen.dart)
- Use `BlocConsumer` to handle navigation and toasts.

#### [MODIFY] [verify_code_body.dart](file:///F:/commerce_app_2/lib/features/auth/view/widgets/forgotPassword/verify_code_body.dart)
- Use `Pinput` package for OTP input.
- Use `BlocConsumer`.

#### [MODIFY] [success_dialog.dart](file:///F:/commerce_app_2/lib/core/utils/widgets/dialogs/success_dialog.dart)
- Use `Assets.images.imgs.checkDuotone.svg()` instead of `Icons.check_circle_outline`.

## Verification Plan

### Automated Tests
- N/A (Manual verification prioritized for UI/Flow).

### Manual Verification
1. **Singleton Verification**: Ensure `Endpoints()` and `SharedPrefHelper()` instances are used.
2. **Splash Flow**: Verify single callback handles both Auth and Unauth states.
3. **Forgot Password**:
   - Validation `onChanged` for all fields.
   - OTP using `Pinput`.
   - Local Notification on first success step.
   - Email passed through the entire flow (no placeholders).
4. **Success Dialog**: Verify Figma image usage and navigation back to login.
5. **Toast**: Verify the single toast function works for both success and error types.
