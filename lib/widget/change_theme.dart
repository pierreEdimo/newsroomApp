import 'package:flutter/material.dart';
import 'package:newsroom/service/theme_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return InkWell(
        onTap: () => themeService.switchTheme(),
        child: Container(
          padding: verticalPadding,
          child: Row(
            children: [
              themeService.getTheme() == ThemeMode.light
                  ? Icon(Icons.dark_mode_outlined)
                  : Icon(Icons.light_mode_outlined),
              horizontalSpace,
              Text(themeService.getTheme() == ThemeMode.light
                  ? "Dark theme"
                  : "Light theme")
            ],
          ),
        ),
      );
    });
  }
}
