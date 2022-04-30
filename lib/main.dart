import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:newsroom/screens/sign_in_screen.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/service/saved_word_service.dart';
import 'package:newsroom/service/theme_service.dart';
import 'package:newsroom/service/bookmark_service.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:newsroom/service/topic_service.dart';
import 'package:newsroom/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newsroom/widget/custom_themes.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

final storage = FlutterSecureStorage();
var box = Hive.box('newsBox');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
      'resource://drawable/res_app_ico',
      [
        NotificationChannel(
            channelKey: "the-Room",
            channelName: "the-Room Notifications",
            channelDescription: "Notification channel for a weekly newslatter",
            defaultColor: Color(0xFFFFFFFF),
            importance: NotificationImportance.High,
            channelShowBadge: true,
            defaultRingtoneType: DefaultRingtoneType.Alarm)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'the-Room',
            channelGroupName: 'The Room Notification')
      ],
      debug: true);

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await Hive.initFlutter();
  await Hive.openBox('newsBox');
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  print(message.data["notification"]);

  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    String? token = await storage.read(key: "jwt");
    if (token == null) return "";
    return token;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArticleService()),
        ChangeNotifierProvider(create: (context) => TopicService()),
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => CommentService()),
        ChangeNotifierProvider(create: (context) => BookMarkService()),
        ChangeNotifierProvider(create: (context) => ThemeService()),
        ChangeNotifierProvider(create: (context) => SavedWordService())
      ],
      builder: (context, child) {
        var currentMode = Provider.of<ThemeService>(context);
        return MaterialApp(
            title: 'newsroom',
            debugShowCheckedModeBanner: false,
            themeMode: currentMode.getTheme(),
            darkTheme: CustomThemes.darkTheme,
            theme: CustomThemes.lightTheme,
            home: Scaffold(
              body: FutureBuilder(
                future: jwtOrEmpty,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  if (snapshot.data == "") {
                    return SignInScreen();
                  } else {
                    return BottomNavigation();
                  }
                },
              ),
            ));
      },
    );
  }
}
