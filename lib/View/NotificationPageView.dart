import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:provider/provider.dart';
import '../Model/NotificationData.dart';
import '../Utils/StyleData.dart';

class NotificationPageView extends StatefulWidget {
  const NotificationPageView({super.key});

  @override
  State<NotificationPageView> createState() => _NotificationPageViewState();
}

class _NotificationPageViewState extends State<NotificationPageView> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false).markAllAsRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: StyleData.appBarColor2,
        title: Text("Notification",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: StyleData.boldFont),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(19.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomePageView(Token: ''),
                ),
              );
            },
            child:  Container(
              child: Image.asset(
                'assets/images/arrow.png',
              ),
            ),),
        ),

      ),
      body:Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          // Print the number of notifications
          print("Number of notifications: ${notificationProvider.notifications.length}");

          return notificationProvider.notifications.isEmpty
              ? Center(child: Text("No notifications available")) // Show a message if there are no notifications
              : ListView.builder(
            itemCount: notificationProvider.notifications.length,
            itemBuilder: (context, index) {
              final reversedIndex = notificationProvider.notifications.length - 1 - index;
              final notification = notificationProvider.notifications[reversedIndex];

              print("Notification at index $index: ${notification.title}, ${notification.body}, isRead: ${notification.isRead}");

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(notification.title),
                      subtitle: Text(
                        notification.body,
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: notification.isRead ? null : Icon(Icons.fiber_new, color: Colors.red),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

    );
  }
}


