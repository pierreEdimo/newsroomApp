import "package:flutter/material.dart";
import 'package:newsroom/screens/reset_password_screen.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/email_input.dart';
import 'package:newsroom/widget/title_row.dart';

class ForgoPassWordScreen extends StatelessWidget {
  ForgoPassWordScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        titleRow(
            "",
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close_outlined),
            ),
            context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: Center(
                  child: emailInput(
                      _emailController, "please enter your e-mail adress"),
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
          ),
        ),
      ),
    );
  }
}
