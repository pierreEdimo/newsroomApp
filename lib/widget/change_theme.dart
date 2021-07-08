import 'package:flutter/material.dart';
import 'package:newsroom/service/theme_service.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return InkWell(
        onTap: () => themeService.switchTheme(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 25.0,
            top: 20.0,
            bottom: 20.0,
            right: 25.0,
          ),
          child: Row(
            children: [
              themeService.getTheme() == ThemeMode.light
                  ? Icon(Icons.dark_mode_outlined)
                  : Icon(Icons.light_mode_outlined),
              SizedBox(
                width: 20.0,
              ),
              themeService.getTheme() == ThemeMode.light
                  ? Text("Dark Mode")
                  : Text("Light Mode")
            ],
          ),
        ),
      );
    });
  }
}
