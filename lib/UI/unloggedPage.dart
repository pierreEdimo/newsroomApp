import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Login.dart';

class UnloggedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              CustomAppBar(
                padding: EdgeInsets.all(20),
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Image(
                        image: AssetImage('image/logo.png'),
                        width: 195,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "findadoctor is an application that allows you to search for the doctors near your city and have information on them, such as their numbers.On top of that ,you get the possibility to read articles on health related topics like sport nutrition and so on. You can bookmark articles and doctors by tapping the bookmark icon. when you're ready, you can view them in your personnal page",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Auth())),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(20),
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.signInAlt),
                        SizedBox(width: 10),
                        Text("Signin/Register")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;
  final EdgeInsetsGeometry padding;

  CustomAppBar(
      {@required this.child, this.height = kToolbarHeight, this.padding});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.white,
      alignment: Alignment.center,
      child: child,
      padding: padding,
    );
  }
}
