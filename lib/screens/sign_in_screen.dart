import 'package:flutter/material.dart';
import 'package:newsroom/model/loginModel.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/widget/bottom_navigation.dart';
import 'package:newsroom/widget/display_diagog.dart';
import 'package:newsroom/widget/email_input.dart';
import 'package:newsroom/widget/go_to_signup.dart';
import 'package:newsroom/widget/password_input.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              emailInput(_emailController),
              SizedBox(
                height: 10,
              ),
              passwordInput(_passWordController),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red.shade600),
                  padding: EdgeInsets.all(15.0),
                  width: 150,
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    LoginModel loginModel = LoginModel(
                        email: _emailController.text,
                        password: _passWordController.text);
                    var statusCode =
                        await Provider.of<AuthService>(context, listen: false)
                            .loginUser(loginModel);
                    if (statusCode != 200) {
                      showErrorDialog(
                        context,
                        "Error",
                        "Neither your Email or Password was found in our database, please try again",
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              goToSignUp(context),
            ],
          ),
        ),
      ),
    );
  }
}
