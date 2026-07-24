import 'package:url_launcher/url_launcher.dart';

const privacyPolicyUrl = 'https://naefun.github.io/workout-tracker/';

Future<bool> openPrivacyPolicy() {
  return launchUrl(
    Uri.parse(privacyPolicyUrl),
    mode: LaunchMode.inAppBrowserView,
  );
}
