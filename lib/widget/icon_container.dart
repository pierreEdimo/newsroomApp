import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final Icon? icon;
  final VoidCallback? onPressed;
  const IconContainer({Key? key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          color: Colors.black,
          icon: icon!,
          onPressed:  onPressed!,
        ),
      ),
    );
  }
}

