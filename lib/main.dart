

import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lead_management_system/View/Push_Notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/NotificationData.dart';
import 'Utils/SaveData.dart';
import 'View/NotificationPageView.dart';
import 'View/SplashView.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const String channelId = 'high_importance_channel';
const String channelName = 'High Importance Notifications';
const String channelDescription = 'This channel is used for important notifications.';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> backgroundHandler(RemoteMessage message) async {
  final Map<String, dynamic>? data = message.data;
  if (data != null) {
    final title = data['title'];
    final body = data['body'];

    if (title != null && body != null) {
      final prefs = await SharedPreferences.getInstance();
      List<String> notificationsJson = prefs.getStringList('notifications') ?? [];
      final newNotification = NotificationModel(title: title, body: body);
      notificationsJson.add(jsonEncode(newNotification.toJson()));
      prefs.setStringList('notifications', notificationsJson);
    }

  }
}

bool _isListenerSetUp = false;
void setupFirebaseMessaging(BuildContext context) {
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  if (!_isListenerSetUp) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final Map<String, dynamic>? data = message.data;
      final notification = message.notification;

      final title = data?['title'] ?? notification?.title;
      final body = data?['body'] ?? notification?.body;

      if (title != null && body != null) {
        final newNotification = NotificationModel(title: title, body: body);
        Provider.of<NotificationProvider>(context, listen: false).addNotification(newNotification);

        final prefs = await SharedPreferences.getInstance();
        List<String> notificationsJson = prefs.getStringList('notifications') ?? [];
        notificationsJson.add(jsonEncode(newNotification.toJson()));
        prefs.setStringList('notifications', notificationsJson);

        // Display local notification
        const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
        const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          title,
          body,
          platformChannelSpecifics,
          payload: jsonEncode(data), // Pass the data as a payload
        );
      }
    });
    _isListenerSetUp = true;
  }
}

Future<void> setupNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification_sound'), // Ensure you have a sound file named 'notification_sound.mp3' in the 'res/raw' directory
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await   setupNotificationChannel();
  final prefs = await SharedPreferences.getInstance();
  final notificationsJson = prefs.getStringList('notifications') ?? [];
  List<NotificationModel> notifications = notificationsJson.map((json) => NotificationModel.fromJson(jsonDecode(json))).toList();

 //Initialize local notification
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        final data = jsonDecode(response.payload!);
        // Debugging: print the payload to ensure data is received correctly
        print('Notification payload: $data');
        final screen = data['screen'];
        print(screen);
        if (screen != null) {
          // Example: If screen is 'YourTargetScreen', navigate to YourTargetScreen
          if (screen == 'NotificationPageView') {
            navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => NotificationPageView()));
          }
          // Add more conditions for other screens if needed
        }
      }
    },
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // Check if app was launched by a notification
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    handleNotificationClick(initialMessage.data);
  }
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
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(
  //         create: (_) {
  //           final provider = NotificationProvider();
  //           provider.setNotifications(notifications);
  //           return provider;
  //         },
  //       ),
  //     ],
  //     child: Builder(
  //       builder: (context) {
  //         setupFirebaseMessaging(context);
  //         return MyApp();
  //       },
  //     ),
  //   ),
  // );
}

void handleNotificationClick(Map<String, dynamic> data) {
  final screen = data['screen'];
  if (screen != null) {
    if (screen == 'NotificationPageView') {
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => NotificationPageView()));
    }
  }
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
      navigatorKey: navigatorKey,
   //   navigatorObservers: <NavigatorObserver>[observer],
      builder: FlutterSmartDialog.init(),
      title: 'HomeFin Express',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:
   SplashView(Token: FCMToken.toString()),
  //  SaveData(),
    );
  }
}

