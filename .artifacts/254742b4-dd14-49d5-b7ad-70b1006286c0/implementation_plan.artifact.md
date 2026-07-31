# Implementation Plan - Global Cairo Font Standardization

Ensure the Cairo font is applied consistently across the entire application by expanding the centralized text style system and mapping it to the full Material 3 `TextTheme`.

## Proposed Changes

### Core Layer (Constants)

#### [MODIFY] [app_text_styles.dart](file:///F:/commerce_app/lib/core/utils/constants/styles/app_text_styles.dart)
- Expand the `AppTextStyles` singleton to include a comprehensive set of styles following the naming convention (e.g., `regular12`, `medium14`, `bold24`).
- Ensure every `TextStyle` explicitly uses `AppStrings.fontFamily`.
- Add variants for:
  - sizes: 12, 14, 16, 18, 20, 24, 32.
  - weights: Regular (w400), Medium (w500), Bold (w700).

---

### Configuration (Theming)

#### [MODIFY] [app_theme_components.dart](file:///F:/commerce_app/lib/config/theming/app_theme_components.dart)
- Update the `textTheme` static variable to map all 15 Material 3 text categories to the new `AppTextStyles`.
- Mapping categories:
  - `display`: bold32, bold24, bold20
  - `headline`: bold20, bold18, bold16
  - `title`: medium18, medium16, medium14
  - `body`: regular16, regular14, regular12
  - `label`: medium14, medium12, regular12

#### [MODIFY] [app_theme.dart](file:///F:/commerce_app/lib/config/theming/app_theme.dart)
- Double-check that `fontFamily: AppStrings.fontFamily` is set at the root `ThemeData` level (it already is, but this is a verification step).

---

### Feature Clean-up

#### [VERIFY] Asset Usages
- Scan for any inline `TextStyle` definitions in the `auth` and `splash` features and replace them with references to `AppTextStyles` or `Theme.of(context).textTheme` to ensure they inherit the Cairo font.

## Verification Plan

### Automated Tests
- Run `dart analyze` to ensure no breaking changes in style references.

### Manual Verification
- Visual inspection of the Splash, Login, and Register screens to confirm all text (labels, hints, buttons, headers) uses the Cairo font.
- Verify that font weights (Bold, Medium, Regular) are distinct and correctly applied as per the Figma design.
