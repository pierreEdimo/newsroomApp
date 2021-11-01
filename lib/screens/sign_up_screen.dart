import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsroom/model/registerModel.dart';
import 'package:newsroom/service/auth_service.dart';
import 'package:newsroom/widget/bottom_navigation.dart';
import 'package:newsroom/widget/display_diagog.dart';
import 'package:newsroom/widget/email_input.dart';
import 'package:newsroom/widget/go_back_to_sign_in.dart';
import 'package:newsroom/widget/password_input.dart';
import 'package:newsroom/widget/username_input.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                emailInput(_emailController, 'please enter your E-mail'),
                SizedBox(
                  height: 10,
                ),
                passwordInput(_passWordController, "please enter a password"),
                SizedBox(
                  height: 10,
                ),
                userNameInput(_userNameController),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black),
                    padding: EdgeInsets.all(15.0),
                    width: 150,
                    child: Text(
                      'Register',
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
                      RegisterModel userModel = RegisterModel(
                        userName: _userNameController.text,
                        passWord: _passWordController.text,
                        email: _emailController.text,
                      );

                      Response response =
                          await Provider.of<AuthService>(context, listen: false)
                              .registerUser(userModel);

                      if (response.statusCode != 200) {
                        List<dynamic> responseJson = jsonDecode(response.body);

                        for (int i = 0; i < responseJson.length; i++) {
                          showErrorDialog(context, responseJson[i]['code'],
                              responseJson[i]['description']);
                        }
                      } else
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomNavigation()));
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                goBack(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
