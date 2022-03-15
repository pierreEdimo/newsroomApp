import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/loginModel.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/bottom_navigation.dart';
import 'package:newsroom/widget/display_dialog.dart';
import 'package:newsroom/widget/password_input.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  final String? email;

  ResetPassword({Key? key, this.email}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Expanded(
                child: Center(
                  child: passwordInput(
                      _passwordController, "Please add a new password"),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  LoginModel login = new LoginModel(
                      email: email, password: _passwordController.text);

                  Response response =
                      await Provider.of<AuthService>(context, listen: false)
                          .resetPassword(login);

                  print(response.statusCode);

                  if (response.statusCode != 200)
                    showErrorDialog(context, "Error", "Reset was unsuccessful");
                  else
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                        (Route<dynamic> route) => false);
                }
              },
              child: Container(
                padding: standardPadding,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Text(
                  "Reset your password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
