import 'package:flutter/material.dart';
import 'package:flutter_app/screens/MyApp.dart';
import 'package:flutter_app/screens/RegisterScreen.dart';
import 'package:flutter_app/screens/ResetPasswordScreen.dart';
import 'package:flutter_app/services/Authenticator.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_app/shared/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  final DataBase db;
  LoginScreen({@required this.db});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _auth = Authenticator();

  final appPrimaryColor = const Color(0xFF1DB954);
  final appAccentColor = const Color(0xff23008B);
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Madhyam',
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.white,

        primaryColor: Theme.of(context).primaryColor,
        accentColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        //cardColor: lightGreyBackground,
        fontFamily: 'AppFont',
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    "Madhyam",
                    style: TextStyle(
                      fontFamily: 'TitleFont',
                      fontSize: 50.0,
                      color: appPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 500,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration:
                              inputTextDecoration.copyWith(hintText: "Email"),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: inputTextDecoration.copyWith(
                              hintText: "Password"),
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ char'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Please provide valid email or password';
                                });
                              } else {
                                await Future.delayed(const Duration(seconds: 1),
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyApp(
                                        db: widget.db,
                                        selectedIndex: 0,
                                      ),
                                    ),
                                  );
                                });
                              }
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          style: primaryButton,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Future.delayed(const Duration(seconds: 1), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(
                            db: widget.db,
                          ),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Forgot your Password ?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                TextButton(
                  onPressed: () async {
                    await Future.delayed(const Duration(seconds: 1), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(
                            db: widget.db,
                          ),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Create an Account',
                    style: TextStyle(
                      color: appAccentColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
