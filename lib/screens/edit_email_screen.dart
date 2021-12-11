import 'package:flutter/material.dart';
import 'package:newsroom/model/edit_email.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/email_input.dart';
import 'package:newsroom/widget/title_row.dart';
import 'package:provider/provider.dart';

class EditmailScreen extends StatefulWidget {
  final String? email;

  EditmailScreen({@required this.email});
  @override
  _EditmailScreenState createState() => _EditmailScreenState(email: email!);
}

class _EditmailScreenState extends State<EditmailScreen> {
  String? email;

  _EditmailScreenState({@required this.email});

  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _controller.text = email!;
    return Scaffold(
      appBar: customAppBar(
        titleRow(
            "email",
            IconButton(
              icon: Icon(Icons.close_outlined),
              onPressed: () => Navigator.of(context).pop(),
            ),
            context),
      ),
      body: Container(
        padding: completePadding ,
        child: Form(
          key: _formKey,
          child: emailInput(_controller, ""),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            EditEmail email = new EditEmail(
              email: _controller.text,
            );
            Provider.of<AuthService>(context, listen: false)
                .editEmail(email)
                .then((_) => Navigator.of(context).pop());
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
