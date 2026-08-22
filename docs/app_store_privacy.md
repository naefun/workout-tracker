# App Store Connect privacy answers

Last audited against the app and bundled iOS SDKs: 25 July 2026

These are conservative answers for the current release. They include the data types declared by the bundled GoogleSignIn iOS SDK (`9.1.0`), not only the fields directly read by the Dart code.

## Data collection

For "Do you or your third-party partners collect data from this app?", answer:

**Yes, we collect data from this app.**

## Data types to select

| App Store data type | Purpose | Linked to the user? | Used for tracking? | Why |
| --- | --- | --- | --- | --- |
| Health & Fitness → Fitness | App Functionality | Yes | No | Workout times, exercise names, sets, reps, and weights stored in Supabase |
| Contact Info → Name | App Functionality | Yes | No | Google Sign-In profile and first-name greeting |
| Contact Info → Email Address | App Functionality | Yes | No | Google Sign-In and Supabase authentication |
| Contact Info → Phone Number | App Functionality | Yes | No | Declared by the bundled GoogleSignIn privacy manifest; the app does not request a phone scope |
| Location → Coarse Location | App Functionality | Yes | No | Declared by GoogleSignIn; authentication services also receive IP/network metadata |
| Identifiers → User ID | App Functionality; Analytics | Yes | No | Google/Supabase account ID and GoogleSignIn SDK declaration |
| Identifiers → Device ID | Analytics | Yes | No | Declared by the bundled GoogleSignIn privacy manifest |
| Usage Data → Other Usage Data | Analytics | Yes | No | Declared by the bundled GoogleSignIn privacy manifest |
| Other Data → Other Data Types | App Functionality; Analytics | Yes | No | Declared by the bundled GoogleSignIn privacy manifest |

For each selected type, answer **No** to tracking. The app does not use data for third-party advertising, developer advertising or marketing, or cross-app tracking.

## Data types not selected for this release

- **Diagnostics:** there is no independent crash-reporting, performance-monitoring, or diagnostics SDK in the current dependency set.
- **Product Interaction:** the app does not add an analytics SDK. Use **Other Usage Data** above because the current GoogleSignIn privacy manifest declares it.
- **Precise Location:** the app does not request location permission.
- Advertising Data, Purchases, Financial Info, Contacts, Photos or Videos, Audio Data, Sensitive Info, Browsing History, and Search History.

## Evidence checked

- `lib/state/user_authentication_state.dart` requests Google `email` and `profile` scopes and sends the resulting tokens to Supabase Auth.
- `lib/state/user_authentication_state.dart` requests Apple name and email scopes, sends the Apple identity token to Supabase Auth, and stores an encrypted Apple refresh token for account-deletion revocation.
- Workout state code stores workouts, exercises, sets, reps, and weights in user-protected Supabase tables after authentication.
- `pubspec.yaml` contains no advertising, analytics, Sentry, Firebase Analytics, or crash-reporting dependency.
- `ios/Pods/GoogleSignIn/GoogleSignIn/Sources/Resources/PrivacyInfo.xcprivacy` declares Name, Email Address, Phone Number, Coarse Location, User ID, Device ID, Other Usage Data, and Other Data Types, linked to the user and not used for tracking.
- Supabase Auth audit logs can store authentication action, timestamp, user ID, IP address, user agent, and provider metadata.

## Submission check

Before every App Store submission:

1. Generate or inspect Xcode's privacy report for the exact archive being submitted.
2. Recheck the current GoogleSignIn privacy manifest after any pod or package update.
3. Update both App Store Connect and the public policy if an SDK or data flow changes.
4. Confirm the public privacy-policy URL loads without authentication.

Apple guidance:

- <https://developer.apple.com/app-store/app-privacy-details/>
- <https://developer.apple.com/help/app-store-connect/manage-app-information/manage-app-privacy>
- <https://developer.apple.com/app-store/review/guidelines/>

## Separate App Review consideration

Sign in with Apple and in-app account deletion are implemented. Authentication is required because workout records are stored against, and retrieved from, the user's Supabase account.
