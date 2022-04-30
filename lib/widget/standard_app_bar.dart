import 'package:flutter/material.dart';
import 'package:newsroom/widget/notification_button.dart';
import 'package:newsroom/widget/search_icon.dart';

class StandardAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final Color? color;
  final double? elevation;

  StandardAppBar({
    this.title,
    this.elevation,
    this.color,
    Key? key,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title!,
      ),
      actions: [
        SearchIcon(),
      ],
    );
  }
}