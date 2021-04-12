import 'package:flutter/material.dart';
import 'package:newsroom/screens/edit_email_screen.dart';

import 'list_tile.dart';

Widget emailTile(email, context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditmailScreen(email: email),
      ),
    ),
    child: listTile(
      Icon(Icons.person),
      email,
    ),
  );
}
