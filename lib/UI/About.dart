import 'package:Newsroom/Component/HeaderDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: headerDetail("About", context),
            ),
            SizedBox(
              height: 20.0,
            ),
            MarkdownBody(
              data: data,
              selectable: true,
              onTapLink: (url, href, title) {
                launch(href);
              },
            ),
          ],
        ),
      ),
    );
  }
}

String data = ('**Newsplace** is a place where registered authors talk about themes they like. ' +
    'We created this application in order to educate and inform the world around us.\n' +
    '\n' +
    '\n' +
    '\n'
        'Our belief is that everyone has the right to be informed, and that education should be free' +
    ' of charge, therefore this application is free and will remain so for life.' +
    ' We do not collect user data, nor do we collect personal information from users.\n' +
    '\n' +
    '\n' +
    '\n' +
    'we are always open for improvements, so if you discover bugs, if you want to support' +
    " us, or even if you want to become an author, don't hesitate to [contact us](mailto:pierredimo@live.com)");
