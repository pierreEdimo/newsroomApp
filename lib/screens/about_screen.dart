import 'package:flutter/material.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/info_container.dart';
import 'package:newsroom/widget/title_row.dart';

String data = "**Newsplace** is a blogging application developed and designed by me," +
    " Pierre Patrice Edimo Nkoe" +
    "\n" +
    "\n" +
    "\n" +
    "**who Am I**" +
    "\n" +
    "\n" +
    "\n" +
    "Hi, I'm Pierre Patrice Edimo, a developer from Cameroon. I " +
    "specialize in web-development as well as the development of " +
    "crossplatform applications\n" +
    "I came to Germany in 2013 to finish my studies. This did not happen as I wanted" +
    "With time, I realized that I was not informed enough in general." +
    "There are a lot of blogging applications in this world," +
    "and they deal with everyday problems, but very few that deal with" +
    "specific problems that one can encounter when living abroad, that's " +
    "what inspired me to create newsplace, I want to share my experience " +
    "and bring other people to share theirs by becoming authors on newsplace" +
    "\n" +
    "\n" +
    "\n" +
    "**why did i create it**" +
    "\n" +
    "\n" +
    "\n" +
    "As I said above, I was not informed enough when I arrived in Germany, which made me make many mistakes. " +
    "But I have learned from those. I learned to code, and I informed myself. " +
    "Today people are leaving their country and have the same problems I had to face," +
    "so I would like to help them as much as possible, " +
    "I would like to help those who have problems with programming" +
    " integration, in every way, if it can make their life better. Check out the application," +
    " I hope you who are reading this will find it useful. If you have any ideas for improvement, feel free to contact me.";

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 100,
        child: titleRow(
            "About",
            IconButton(
              icon: Icon(Icons.close_outlined),
              onPressed: () => Navigator.of(context).pop(),
            ),
            context),
      ),
      body: inforMationContainer(
        data,
      ),
    );
  }
}
