// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

launchURLs(String urlString) async {
  if (Platform.isIOS) {
    if (await canLaunch(urlString)) {
      await launch(
        urlString,
        forceSafariVC: false,
      );
    } else {
      if (await canLaunch(urlString)) {
        await launch(urlString);
      } else {
        throw 'Could not launch $BigInt';
      }
    }
  } else {
    if (await canLaunch(urlString)) {
      await launch(
        urlString,
        forceSafariVC: false,
      );
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
