import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/loginModel.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/bottom_navigation.dart';
import 'package:newsroom/widget/display_dialog.dart';
import 'package:newsroom/widget/email_input.dart';
import 'package:newsroom/widget/forgot_password_button.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: all25Padding,
          height: MediaQuery.of(context).size.height * 1,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  emailInput(_emailController, 'please enter your E-mail'),
                  verticalSpace,
                  passwordInput(_passWordController, "please choose your password"),
                  verticalSpace,
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.black),
                      padding: all10Padding,
                      width: 150,
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        LoginModel loginModel = LoginModel(
                            email: _emailController.text,
                            password: _passWordController.text);

                        Response response =
                            await Provider.of<AuthService>(context, listen: false)
                                .loginUser(loginModel);

                        if (response.statusCode != 200)
                          showErrorDialog(context, "Error",
                              "Sorry, Neither your password nor your email were found");
                        else
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => BottomNavigation(),
                            ),
                          );
                      }
                    },
                  ),
                  verticalSpace,
                  goToSignUp(context),
                  forgotPassWordButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
