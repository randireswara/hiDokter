import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:get/get.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final FlutterLocalNotificationsPlugin _localNotificationService =
      FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    _configureLocalTimezone();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_access_alarms');

    var iOSInitializationSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await _localNotificationService.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    final details = await _notificationDetails();
    return _localNotificationService.show(id, title, body, details);
  }

  Future<void> scheduledNotification(int hour, int minutes, Map task) async {
    final details = await _notificationDetails();
    print("ini myTime yang ada di notifikasi $hour + $minutes");

    await _localNotificationService.zonedSchedule(task["id"], task["drugName"],
        task["longDay"], _convertTime(hour, minutes), details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task["drugName"]}|"
            "${task["longDay"]}|");
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("ini myTime yang ada di convert $hour + $minutes");
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      if (payload == "Theme Change") {
      } else {
        Get.back();
      }
    } else {}
  }

  Future<void> showNotificationWithPayload(
      {required int id,
      required String title,
      required String body,
      required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
  }
}



//   Future<void> showNotification(
//       {required int id, required String title, required String body}) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details,
//         payload: title);
//   }

//   scheduledNotification(int hour, int minutes, Map task) async {
//     final details = await _notificationDetails();

//     await _localNotificationService.zonedSchedule(task["id"], task["drugName"],
//         task["longDay"], _convertTime(hour, minutes), details,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         androidAllowWhileIdle: true,
//         matchDateTimeComponents: DateTimeComponents.time,
//         payload: "${task["drugName"]}|"
//             "${task["longDay"]}|");
//   }

//   tz.TZDateTime _convertTime(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduleDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
//     if (scheduleDate.isBefore(now)) {
//       scheduleDate = scheduleDate.add(const Duration(days: 1));
//     }
//     return scheduleDate;
//   }

//   Future<void> _configureLocalTimezone() async {
//     tz.initializeTimeZones();
//     final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZone));
//   }

//   Future selectNotification(String? payload) async {
//     if (payload != null) {
//       if (payload == "Theme Change") {
//       } else {
//         Get.back();
//       }
//     } else {}
//   }

//   Future<void> showNotificationWithPayload(
//       {required int id,
//       required String title,
//       required String body,
//       required String payload}) async {
//     final details = await _notificationDetails();
//     await _localNotificationService.show(id, title, body, details,
//         payload: payload);
//   }

//   void _onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) {
//     print('id $id');
//   }

//   void onSelectNotification(String? payload) {
//     print('payload $payload');
//   }
// }
