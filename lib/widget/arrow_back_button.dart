import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsroom/widget/icon_container.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconContainer(
      horizontal: 5.0,
      vertical: 0.0,
      icon: FaIcon(FontAwesomeIcons.angleLeft),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
