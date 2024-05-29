import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationModel {
  final String title;
  final String body;
  bool isRead;

  NotificationModel({
    required this.title,
    required this.body,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      isRead: json['isRead'] ?? false,
    );
  }
}

// class NotificationProvider with ChangeNotifier {
//   List<NotificationModel> _notifications = [];
//   int _latestUnreadCount = 0;
//
//   List<NotificationModel> get notifications => _notifications;
//   int get unreadCount => _latestUnreadCount;
//
//   void addNotification(NotificationModel notification) {
//     _notifications.add(notification);
//     if (!notification.isRead) {
//       _latestUnreadCount++;
//     }
//     notifyListeners();
//   }
//
//   void setNotifications(List<NotificationModel> notifications) {
//     _notifications = notifications;
//     _latestUnreadCount = _notifications.where((notification) => !notification.isRead).length;
//     notifyListeners();
//   }
//
//   void markAllAsRead() {
//     for (var notification in _notifications) {
//       notification.isRead = true;
//     }
//     _latestUnreadCount = 0;
//     notifyListeners();
//   }
//
//   void resetUnreadCount() {
//     _latestUnreadCount = 0;
//     notifyListeners();
//   }
// }

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((notification) => !notification.isRead).length;

  NotificationProvider() {
    _loadNotificationsFromPrefs();
  }

  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
    _saveNotificationsToPrefs();
    notifyListeners();
  }

  void setNotifications(List<NotificationModel> notifications) {
    _notifications = notifications;
    _saveNotificationsToPrefs();
    notifyListeners();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    _saveNotificationsToPrefs();
    notifyListeners();
  }

  Future<void> _saveNotificationsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notificationsJson = _notifications.map((n) => jsonEncode(n.toJson())).toList();
    prefs.setStringList('notifications', notificationsJson);
  }

  Future<void> _loadNotificationsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? notificationsJson = prefs.getStringList('notifications');
    if (notificationsJson != null) {
      _notifications = notificationsJson.map((json) => NotificationModel.fromJson(jsonDecode(json))).toList();
      notifyListeners();
    }
  }
}



