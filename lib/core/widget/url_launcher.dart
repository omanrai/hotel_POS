import 'package:url_launcher/url_launcher.dart';

final Uri forgetPasswordUrl =
    Uri.parse('https://digitalpaana.sainotech.com/forget-password');
final Uri playStoreUrl = Uri.parse(
    'https://play.google.com/store/apps/details?id=com.sainotech.digitalgurukul');
final Uri nebResultUrl = Uri.parse('https://neb.ntc.net.np/results.php');
final Uri aboutUsUrl = Uri.parse('https://sainotech.com/team');
final Uri aboutAppUrl = Uri.parse('https://digitalpaana.sainotech.com/');
final Uri deleteUserDataUrl = Uri.parse(
    'https://docs.google.com/forms/d/1IdW3YMI5lk7aGfDPCZSN0g_-7Iq68yobFd2G15ZLISU/viewform?edit_requested=true');
final Uri appPolicyUrl =
    Uri.parse('https://digitalpaana.sainotech.com/privacy-policy');

Future<void> urlLauncher(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
    // if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
    throw Exception('Could not launch $url');
  }
}
