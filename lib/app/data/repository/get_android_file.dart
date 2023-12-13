//import 'package:flutter/services.dart';

// class GetAndroidFile{
//
//   static const platform = MethodChannel('samples.flutter.dev/battery');
//   // Get battery level.
//
//   final String _batteryLevel = 'Unknown battery level.';
//
//   Future<void> _getBatteryLevel() async {
//     String batteryLevel;
//     try {
//       final int result = await platform.invokeMethod('openDirectory');
//       batteryLevel = 'Battery level at $result % .';
//     } on PlatformException catch (e) {
//       batteryLevel = "Failed to get battery level: '${e.message}'.";
//     }
//
//     // setState(() {
//     //   _batteryLevel = batteryLevel;
//     // });
//   }
// }