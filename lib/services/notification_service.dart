import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import "package:get/get.dart";
import "package:flutter/cupertino.dart";
import "package:timezone/timezone.dart" as tz;
import "package:timezone/data/latest.dart" as tz;
import 'package:to_do_app_2/screens/notified_page.dart';

import '../models/task.dart';


class NotifyHelper{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimezone();
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");

    final InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse
    );
  }

  // void requestIOSPermissions() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }



  void _onDidReceiveNotificationResponse(NotificationResponse payload){
    // if (payload != null) {
    //   print('notification payload: $payload');
    // } else {
    //   print("Notification Done");
    // }
    if(payload.payload == "Theme Changed"){
      print("Nothing to navigate");
    }else{
      Get.to(()=>NotifiedPage(label: payload.payload!,));
    }
  }

  displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription : 'your channel description',
        importance: Importance.max, priority: Priority.high);

    var darwinPlatformChannelSpecifics = DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: darwinPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: "Theme Changed",
    );
  }

  tz.TZDateTime _convertTime(int hour, int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async{
    tz.initializeTimeZones();
    final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    if(timezone == "Asia/Yangon"){
      tz.setLocalLocation(tz.getLocation("Asia/Rangoon"));
    }else{
      tz.setLocalLocation(tz.getLocation(timezone));
    }
  }

  scheduledNotification(bool isStart,int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        isStart ? task.id! : (-1)*task.id!,
        isStart ? "${task.title}  [START TIME]" : "${task.title}  [END TIME]",
        task.note,
        _convertTime(hour, minutes),
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: minutes)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', channelDescription:'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.id}|${task.title}|${task.note}|${task.startTime}|${task.endTime}|${task.repeat}|${task.remind}|${task.isCompleted}",
    );
  }



  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
    }
    else if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!.requestPermission(
      );
      // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      //     AndroidFlutterLocalNotificationsPlugin>();
    }
  }

  // Future onDidReceiveLocalNotification(int id ,String? title ,String? body ,String? payload) async{
  //   Get.dialog(Text("Welcome to flutter"));
  // }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotifiedPage(label: payload!),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  deleteNotification(int id) async{
    await flutterLocalNotificationsPlugin.cancel(id);
    await flutterLocalNotificationsPlugin.cancel((-1)*id);
  }
}