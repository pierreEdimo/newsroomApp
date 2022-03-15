import "package:flutter/material.dart";
import 'package:newsroom/screens/reset_password_screen.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/email_input.dart';

class ForgoPassWordScreen extends StatelessWidget {
  ForgoPassWordScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: all25Padding,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: Center(
                  child: emailInput(
                      _emailController, "please enter your e-mail address"),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ResetPassword(
                  email: _emailController.text,
                ),
              ),
            );
          }
        },
        child: Text(
          "Save",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "OpenSansBold",
          ),
        ),
      ),
    );
  }
}
