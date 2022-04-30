import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsroom/screens/search_screen.dart';

import 'icon_container.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconContainer(
      horizontal: 15.0,
      vertical: 5.0,
      icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchScreen(),
        ),
      ),
    );
  }
}
