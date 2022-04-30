import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconContainer extends StatelessWidget {
  final FaIcon? icon;
  final VoidCallback? onPressed;
  final double? horizontal;
  final double? vertical;

  const IconContainer({
    Key? key,
    this.icon,
    this.onPressed,
    this.vertical,
    this.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: vertical!,
        horizontal: horizontal!,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          color: Colors.black,
          icon: icon!,
          onPressed: onPressed!,
          iconSize: 22.0,
        ),
      ),
    );
  }
}
