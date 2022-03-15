import 'package:flutter/material.dart';
import 'package:newsroom/widget/icon_container.dart';

Widget closeIcon(BuildContext context){
  return IconContainer(
    icon: Icon(Icons.close),
    onPressed: () => Navigator.of(context).pop() ,
  );
}