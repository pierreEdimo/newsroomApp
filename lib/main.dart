import 'package:flutter/services.dart';
import 'package:newsroom/screens/sign_in_screen.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/service/theme_service.dart';
import 'package:newsroom/service/bookmark_service.dart';
import 'package:newsroom/service/comment_service.dart';
import 'package:newsroom/service/topic_service.dart';
import 'package:newsroom/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newsroom/widget/custom_themes.dart';
import 'package:provider/provider.dart';

final storage = FlutterSecureStorage();

void main() async {
  runApp(MyApp());
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
        ChangeNotifierProvider(create: (context) => BookMarkSerivce()),
        ChangeNotifierProvider(create: (context) => ThemeService()),
      ],
      builder: (context, child) {
        var currentMode = Provider.of<ThemeService>(context);
        return MaterialApp(
          title: 'newsroom',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode.getTheme(),
          darkTheme: CustomThemes.darkTheme,
          theme: CustomThemes.lightTheme,
          home: FutureBuilder(
            future: jwtOrEmpty,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              if (snapshot.data == "") {
                return SignInScreen();
              } else {
                return BottomNavigation();
              }
            },
          ),
        );
      },
    );
  }
}
