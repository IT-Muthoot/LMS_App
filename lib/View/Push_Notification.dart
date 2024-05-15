import 'package:firebase_messaging/firebase_messaging.dart';




class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {

    await _fcm.requestPermission();
    final Token = await _fcm.getToken();
    print('Token : $Token');
  }

}