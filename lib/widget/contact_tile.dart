import 'package:flutter/material.dart';
import 'package:newsroom/widget/list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

_sendEmail() async {
  const url = 'mailto:pierredimo@live.com?subject=&body=%20';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget contactTile(context) {
  return InkWell(
    onTap: () => _sendEmail(),
    child: listTile(
      Icon(Icons.email_outlined, size: 25,),
      "Contact",
    ),
  );
}
