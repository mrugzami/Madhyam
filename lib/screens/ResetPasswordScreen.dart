import 'package:flutter/material.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_app/services/Authenticator.dart';
import 'package:flutter_app/shared/constant.dart';

import 'LoginScreen.dart';

class ResetPassword extends StatefulWidget {
  final DataBase db;
  ResetPassword({@required this.db});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  static final _auth = Authenticator();

  final appPrimaryColor = const Color(0xFF1DB954);
  final appAccentColor = const Color(0xff23008B);
  final _formKey = GlobalKey<FormState>();
  String email = '';
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
                    "Reset Password",
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
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result = _auth.sendPasswordReset(email);

                              if (result == null) {
                                setState(() {
                                  error = 'Something is wrong with email';
                                });
                              } else {
                                _showPasswordEmailSentDialog();
                              }
                            }
                          },
                          child: Text(
                            'RESET PASSWORD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          style: primaryButton,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            db: widget.db,
                          ),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Back to Login',
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

  void _showPasswordEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Forgot your password"),
          content: new Text(
              "Reset password link has been sent to \n" + email + " address"),
          actions: <Widget>[
            new TextButton(
              child: new Text("Okay"),
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        db: widget.db,
                      ),
                    ),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
