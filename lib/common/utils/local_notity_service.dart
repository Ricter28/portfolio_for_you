import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

@Singleton()
class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('logo.png');

     const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

    const InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: initializationSettingsDarwin);

    await _localNotificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
      },
    );
  }

  Future<NotificationDetails> _notificationDetail() async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id', 
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true
    );

    const DarwinNotificationDetails iosNotificationDetail = DarwinNotificationDetails();

    return const NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetail);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
  }

  Future<void> showNotification({
    required int id, 
    required String title,
    required String body,
  }) async {
    final detail = await _notificationDetail();
    await _localNotificationService.show(id, title, body, detail);
  }

  Future<void> showScheduleNotification({
    required int id, 
    required String title,
    required String body,
    required int second,
  }) async {
    final detail = await _notificationDetail();
    await _localNotificationService.zonedSchedule(
      id, 
      title, 
      body, 
      tz.TZDateTime.from(DateTime.now().add(Duration(seconds: second)), tz.local),
      detail, 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true
    );
  }
}
