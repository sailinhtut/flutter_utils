








// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:developer' as logger;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

LanceLogger logLance = LanceLogger();

/// Debug Output
class LanceLogger {
  static int step = 1;

  void call(String message, {bool force = false, bool stepping = false, bool resetStep = false}) {
    if (kDebugMode || force) {
      resetStep ? step = 1 : null;

      logger.log("Lance Log ${stepping ? "[ Step - $step ]" : ""} ---> $message", name: "Juzgo Service");

      stepping ? step++ : null;
    }
  }
}

// Extensions
extension BuildContextExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
}

void toast(String message) => Fluttertoast.showToast(msg: message);

void snack(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

Widget sizeHeight(double height) => SizedBox(height: height);

Widget sizeWidth(double width) => SizedBox(width: width);

void showMessage(String title, String message, {int? delaySeconds, TextButton? action}) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10).copyWith(bottom: 20),
      backgroundColor: Colors.black,
      mainButton: action,
      duration: Duration(seconds: delaySeconds ?? 3),
      colorText: Colors.white);
}

Future<void> showConfirmDialog(BuildContext context,
    {required String title, required String content, required String buttonText, required VoidCallback onConfirm}) async {
  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title)],
            ),
            content: Text(content),
            scrollable: true,
            titlePadding: const EdgeInsets.all(25).copyWith(bottom: 0),
            contentPadding: const EdgeInsets.all(25).copyWith(bottom: 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(style: TextButton.styleFrom(foregroundColor: Theme.of(context).primaryColor), onPressed: onConfirm, child: Text(buttonText)),
            ],
          ));
}

/// Color Converter
MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

/// Check Internet
Future<bool> checkConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

String splitter(String? username) {
  if (username == null) {
    return "Username";
  }

  final words = username.split(" ");

  if (words.isEmpty) {
    return "No Username";
  } else if (words.isNotEmpty) {
    final firstCap = words[0].substring(0, 1).toUpperCase();
    // final secondCap = words[1].substring(0, 1).toUpperCase();
    return firstCap;
  } else {
    return words.first.toUpperCase();
  }
}

/// Timestamp to Datetime
///
/// Already handled null safety.
DateTime timestampToDateTime(dynamic timestamp) {
  if (timestamp == null) {
    return DateTime.now();
  }
  final milliseconds = (timestamp as Timestamp).millisecondsSinceEpoch;
  return DateTime.fromMillisecondsSinceEpoch(milliseconds);
}

/// Datetime to Timestamp
Timestamp datetimeToTimestamp(DateTime date) {
  return Timestamp.fromDate(date);
}
