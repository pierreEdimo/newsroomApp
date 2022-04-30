import 'package:flutter/material.dart';
import 'package:newsroom/widget/standard_app_bar.dart';

class PodCastScreen extends StatelessWidget {
  const PodCastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(
        title: "Podcasts",
      ),
      body: Center(
        child: Text("Hello World!"),
      ),
    );
  }
}
