import 'package:flutter/cupertino.dart';

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

  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void setNotifications(List<NotificationModel> notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }
}

