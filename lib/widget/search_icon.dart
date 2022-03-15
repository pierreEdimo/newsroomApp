import 'package:flutter/material.dart';
import 'package:newsroom/screens/search_screen.dart';

import 'icon_container.dart';

Widget searchIcon(BuildContext context) {
  return IconContainer(
    icon: Icon(Icons.search),
    onPressed: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchScreen(),
      ),
    ),
  );
}
