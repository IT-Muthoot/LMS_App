import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lead_management_system/View/HomePageView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/NotificationData.dart';
import '../Utils/StyleData.dart';
import '../main.dart';

class NotificationPageView extends StatefulWidget {
  const NotificationPageView({super.key});

  @override
  State<NotificationPageView> createState() => _NotificationPageViewState();
}

class _NotificationPageViewState extends State<NotificationPageView> {

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
          // Mark all notifications as read when the page is opened
          WidgetsBinding.instance.addPostFrameCallback((_) {
            notificationProvider.markAllAsRead();
          });

          return ListView.builder(
            itemCount: notificationProvider.notifications.length,
            itemBuilder: (context, index) {
              final reversedIndex = notificationProvider.notifications.length - 1 - index;
              final notification = notificationProvider.notifications[reversedIndex];
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



