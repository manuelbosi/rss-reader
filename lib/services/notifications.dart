import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rss_reader/services/api.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'newFeedNotification':
        log("Running background fetch...");
        await checkFeedsAndSendNotification();
        return Future.value(true);
      default:
        break;
    }

    return Future.value(true);
  });
}

void showNotificationWithDefaultSound(flip) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channel_feed',
    'Feeds',
    importance: Importance.high,
    priority: Priority.high,
  );
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flip.show(
    0,
    'NEW FEED WAS FOUND',
    'New feed was found with your keyword! Check it here.',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

FlutterLocalNotificationsPlugin setupNotification() {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var ios = const IOSInitializationSettings();

  var settings = InitializationSettings(android: android, iOS: ios);
  flip.initialize(settings);
  return flip;
}
