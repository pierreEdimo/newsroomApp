import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsroom/screens/notification_screen.dart';
import 'package:newsroom/widget/icon_container.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconContainer(
      horizontal: 15.0,
      vertical: 5.0,
      icon: FaIcon(FontAwesomeIcons.bell),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotificationScreen(),
        ),
      ),
    );
  }
}
