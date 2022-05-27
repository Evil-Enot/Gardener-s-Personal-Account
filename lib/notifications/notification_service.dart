import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  AndroidNotificationDetails android = const AndroidNotificationDetails(
    'channel ID',
    'channel Name',
    channelDescription: 'repeating description',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> scheduleNotifications() async {
    // final now = tz.TZDateTime.now(tz.local);
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   0,
    //   "Время передать показания",
    //   "Не забудьте передать показания с 20 по 25 числа текущего месяца!",
    //   tz.TZDateTime.local(now.year, now.month + 1, 27, 22, 29),
    //   NotificationDetails(
    //       android: android, iOS: const IOSNotificationDetails(),),
    //   androidAllowWhileIdle: true,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    // );
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        "Время передать показания",
        "Не забудьте передать показания с 20 по 25 числа текущего месяца!",
        RepeatInterval.everyMinute,
        NotificationDetails(
          android: android,
          iOS: const IOSNotificationDetails(),
        ),
        androidAllowWhileIdle: true);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
