import 'package:flutter/material.dart';
import 'package:Newsroom/Model/LoginModel.dart';
import 'package:Newsroom/Model/UserModel.dart';
import 'package:Newsroom/Service/AuthService.dart';
import 'package:Newsroom/main.dart';

enum AuthMode { SignUp, SignIn }

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Login()),
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
  final TextEditingController _professionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getJwt();
  }

  getJwt() async {
    var jwt = await storage.read(key: "jwt");
    print(jwt);
  }

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
                if (jwt == 200) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation()));
                } else {
                  displayDialog(context, "Error",
                      "No account was found matching that username and password,please try again");
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
                      controller: _professionController,
                      decoration: InputDecoration(
                          labelText: 'profession',
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
                  passWord: _passwordController.text,
                  email: _emailController.text,
                  profession: _professionController.text,
                );

                var res = await _authService.registerUser(userModel);
                if (res == 200) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation()));
                } else if (res == 500) {
                  displayDialog(context, "Error",
                      "Something went wrong , possibles reasons are that your username or Email are already in use, your username should also contains number ,  your E-mail should contains @, and your password should be > 7 characters, please try again.");
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
