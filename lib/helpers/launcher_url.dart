import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

/// Use this function to launch the website in the browser
///
/// The argument [url] is the address to visit
Future<void> launchWebsite(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    final nativeAppLaunchSucceeded = await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  } else {
    throw 'Can\'t start $url';
  }
}

/// Use this function to launch maps
///
/// [lat] = Latitude || [lng] = Longitude
///
/// The arguments [lat] & [lng] are the coordinates to visit
Future<void> launchMaps(String lat, String lng) async {
  final Uri googleMapsUrl = Uri.parse("geo:$lat,$lng");
  final Uri appleMapsUrl = Uri.parse("https://maps.apple.com/?q=$lat,$lng");

  try {
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    }
    if (Platform.isIOS) {
      if (await canLaunchUrl(appleMapsUrl)) {
        final nativeAppLaunchSucceeded = await launchUrl(
          appleMapsUrl,
          mode: LaunchMode.externalNonBrowserApplication,
        );
        if (!nativeAppLaunchSucceeded) {
          await launchUrl(
            appleMapsUrl,
            mode: LaunchMode.inAppWebView,
          );
        }
      }
    }
  } catch (e) {
    throw "Can't start Maps";
  }
}

Future<void> launchMapsByAddress(String address) async {
  final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/${Uri.encodeFull(address)}");
  final Uri appleMapsUrl =
      Uri.parse("https://maps.apple.com/?q=${Uri.encodeFull(address)}");

  try {
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      if (Platform.isIOS) {
        if (await canLaunchUrl(appleMapsUrl)) {
          final nativeAppLaunchSucceeded = await launchUrl(
            appleMapsUrl,
            mode: LaunchMode.externalNonBrowserApplication,
          );
          if (!nativeAppLaunchSucceeded) {
            await launchUrl(
              appleMapsUrl,
              mode: LaunchMode.externalApplication,
            );
          }
        }
      } else {
        await launchUrl(
          googleMapsUrl,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  } catch (e) {
    throw "Can't start Maps";
  }
}

/// Use this function to launch maps
///
/// [lat] = Latitude || [lng] = Longitude
///
/// The arguments [lat] & [lng] are the coordinates to visit
Future<void> navigateMaps(String lat, String lng) async {
  final Uri googleMapsUrl = Uri.parse("google.navigation:q=$lat,$lng");

  try {
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    }
  } catch (e) {
    throw "Can't start Maps";
  }
}
