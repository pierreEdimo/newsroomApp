import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:findadoctor/Model/LoginModel.dart';
import 'package:findadoctor/Model/UserModel.dart';
import 'package:findadoctor/Service/AuthService.dart';
import 'package:findadoctor/main.dart';

enum AuthMode { SignUp, SignIn }

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  //Future<UserModel> _futureUser;
  final AuthService _authService = AuthService();
  AuthMode _authMode = AuthMode.SignIn;
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

  Widget textQuestion() {
    if (_authMode == AuthMode.SignUp) {
      return Text("already registered ?");
    }
    return Text("Does not have an account ?");
  }

  Widget signIn() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
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
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red.shade600),
                padding: EdgeInsets.all(15.0),
                width: 150,
                child: Text(
                  'SignIn',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: () async {
                LoginModel loginModel = LoginModel(
                    email: _emailController.text,
                    password: _passwordController.text);
                var jwt = await _authService.loginUser(loginModel);
                print(jwt);
                if (jwt != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation()));
                }
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

  Widget signUp() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
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
            Container(
              padding: EdgeInsets.all(10),
              child: Form(
                child: Column(
                  children: <Widget>[
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
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                          labelText: 'telephone Number',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.red.shade600),
                padding: EdgeInsets.all(15.0),
                width: 150,
                child: Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: () async {
                UserModel userModel = UserModel(
                    userName: _usernameController.text,
                    phoneNumber: _phoneNumberController.text,
                    location: '',
                    city: '',
                    country: '',
                    poBox: '',
                    passWord: _passwordController.text,
                    email: _emailController.text,
                    firstName: '',
                    lastName: '');

                var res = await _authService.registerUser(userModel);
                if (res == 200) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation()));
                }
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

  @override
  Widget build(BuildContext context) {
    if (_authMode == AuthMode.SignIn) {
      return Container(
        child: SingleChildScrollView(
          child: signIn(),
        ),
      );
    } else {
      return Container(
        child: SingleChildScrollView(
          child: signUp(),
        ),
      );
    }
  }
}
