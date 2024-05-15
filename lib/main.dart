

import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lead_management_system/View/Push_Notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/NotificationData.dart';
import 'View/SplashView.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  final Map<String, dynamic>? data = message.data;
  if (data != null) {
    final title = data['title'];
    final body = data['body'];

    print('Received Data Message - Title: $title, Body: $body');

    if (title != null && body != null) {
      final prefs = await SharedPreferences.getInstance();
      List<String> notificationsJson = prefs.getStringList('notifications') ?? [];
      final newNotification = NotificationModel(title: title, body: body);
      notificationsJson.add(jsonEncode(newNotification.toJson()));
      prefs.setStringList('notifications', notificationsJson);

      // Notify the provider
      final provider = NotificationProvider();
      provider.addNotification(newNotification);

      print('Notifications stored in SharedPreferences: $notificationsJson');
    }
  }
}

bool _isListenerSetUp = false;
void setupFirebaseMessaging(BuildContext context) {
  // Check if the listener is already set up
  if (!_isListenerSetUp) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received message in foreground: ${message.data}');

      final Map<String, dynamic>? data = message.data;
      final notification = message.notification;

      final title = data?['title'] ?? notification?.title;
      final body = data?['body'] ?? notification?.body;

      if (title != null && body != null) {
        print('Received Data Message in foreground - Title: $title, Body: $body');

        final newNotification = NotificationModel(title: title, body: body);
        Provider.of<NotificationProvider>(context, listen: false).addNotification(newNotification);

        final prefs = await SharedPreferences.getInstance();
        List<String> notificationsJson = prefs.getStringList('notifications') ?? [];
        notificationsJson.add(jsonEncode(newNotification.toJson()));
        prefs.setStringList('notifications', notificationsJson);
      } else {
        print('Data message received in foreground but title or body is null');
      }
    });
    _isListenerSetUp = true;
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  final prefs = await SharedPreferences.getInstance();
  final notificationsJson = prefs.getStringList('notifications') ?? [];
  List<NotificationModel> notifications = notificationsJson.map((json) => NotificationModel.fromJson(jsonDecode(json))).toList();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) {
              final provider = NotificationProvider();
              provider.setNotifications(notifications);
              return provider;
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            setupFirebaseMessaging(context);
            return MyApp();
          },
        ),
      ),
    ),
  );
}





class MyApp extends StatelessWidget {
  MyApp({Key? key,}) : super(key: key);

  FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? FCMToken;

  Future<void> initialize() async {

    await _fcm.requestPermission();
    FCMToken = await _fcm.getToken();
    print('Token : $FCMToken');
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("fcmToken", FCMToken.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
   //   navigatorObservers: <NavigatorObserver>[observer],
      builder: FlutterSmartDialog.init(),
      title: 'HomeFin Express',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:
      SplashView(Token: FCMToken.toString()),
      //SaveData(),
    );
  }
}

