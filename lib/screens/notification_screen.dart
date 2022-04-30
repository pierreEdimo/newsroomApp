import 'package:flutter/material.dart';

import '../widget/close_icon.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Notifications',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [closeIcon(context)],
      ),
      body: Center(
        child: Text("Hello Notification"),
      ),
    );
  }
}
