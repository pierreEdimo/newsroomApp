import 'package:flutter/material.dart';

PreferredSize customAppBar(Widget child) {
  return PreferredSize(
      child: Material(
        elevation: 0.3,
        child: SafeArea(
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child:  child,
          ),
        ),
      ),
      preferredSize: Size.fromHeight(60.0));
}
