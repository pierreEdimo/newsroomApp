import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsroom/widget/icon_container.dart';

Widget closeIcon(BuildContext context) {
  return IconContainer(
    vertical: 0.0,
    horizontal: 15.0,
    icon: FaIcon(
      FontAwesomeIcons.xmark,
    ),
    onPressed: () => Navigator.of(context).pop(),
  );
}
