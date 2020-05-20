import 'package:findadoctor/Model/UserModel.dart';
import 'package:findadoctor/Service/AuthService.dart';
import 'package:flutter/material.dart';

enum AuthMode { SignUp, SignIn }

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Auth(),
            )
          ],
        ),
      ),
    );
  }
}

class Auth extends StatefulWidget {
  const Auth({Key key}) : super(key: key);
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  AuthMode _authMode = AuthMode.SignIn;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _poBoxController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  //Future<UserModel> _futureUser;
  final AuthService _authService = AuthService();

  void _switchMode() {
    if (_authMode == AuthMode.SignIn) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.SignIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_authMode == AuthMode.SignUp) {
      return Container(
        child: SingleChildScrollView(child: signUp()),
      );
    }
    return Container(
      child: SingleChildScrollView(child: login()),
    );
  }

  Widget switchButton() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        textQuestion(),
        InkWell(
            child: Text(
              '${_authMode == AuthMode.SignIn ? 'SIGNUP' : 'LOGIN'} INSTEAD',
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
            onTap: () => _switchMode()),
      ],
    ));
  }

  Widget login() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('image/logo.png'),
                width: 195,
              ),
            ),
            SizedBox(height: 20),
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        labelText: 'E-mail', border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Invalid E-mail";
                      }
                      return value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return "Invalid PassWord";
                      }
                      return value;
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            switchButton()
          ],
        ),
      ),
    );
  }

  Widget signUp() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('image/logo.png'),
                width: 195,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        labelText: 'Firstname', border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        labelText: 'Lastname', border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'E-mail', border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Invalid E-mail";
                      }
                      return value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return "Invalid PassWord";
                      }
                      return value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        labelText: 'Usermame', border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                        labelText: 'Address', border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                          labelText: 'City', border: OutlineInputBorder()),
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _countryController,
                    decoration: InputDecoration(
                        labelText: 'Country', border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: _poBoxController,
                      decoration: InputDecoration(
                          labelText: 'Postal Box',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                        labelText: 'telephone Number',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'Register',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () async {
                UserModel userModel = UserModel(
                    userName: _usernameController.text,
                    phoneNumber: _phoneNumberController.text,
                    location: _locationController.text,
                    city: _cityController.text,
                    country: _countryController.text,
                    poBox: _poBoxController.text,
                    passWord: _passwordController.text,
                    email: _emailController.text,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text);

                _authService.registerUser(userModel);
              },
            ),
            SizedBox(
              height: 20,
            ),
            switchButton()
          ],
        ),
      ),
    );
  }

  Widget textQuestion() {
    if (_authMode == AuthMode.SignUp) {
      return Text("already registered ?");
    }
    return Text("Does not have an account ?");
  }
}
