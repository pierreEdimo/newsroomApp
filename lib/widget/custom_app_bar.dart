import 'package:flutter/material.dart';

PreferredSize customAppBar(Widget child, double height) {
  return PreferredSize(
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: child,
      ),
      preferredSize: Size.fromHeight(height));
}
