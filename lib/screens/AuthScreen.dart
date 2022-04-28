import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginScreen.dart';
import 'package:flutter_app/screens/MyApp.dart';
import 'package:flutter_app/services/Authenticator.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  static final _auth = Authenticator();
  final db = DataBase(auth: _auth);
  final appPrimaryColor = const Color(0xff4CAF50);
  final appAccentColor = const Color(0xff23008B);
  bool isAuthenticated;

  void printCurrentUserData() async {
    var currentUser = await _auth.getCurrentFireBaseUserID();
    var userPhone = await _auth.getCurrentFireBaseUserEmail();
    print('user is $currentUser');
    print('user email $userPhone');
  }

  void navigateToCorrectPage() async {
    isAuthenticated = await _auth.isUserAuthenticated();
    if (isAuthenticated) {
      print('navigating to APP!!!');
      await Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(
              db: db,
              selectedIndex: 0,
            ),
          ),
        );
      });
    } else {
      print("navigating to Login");
      await Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(
              db: db,
            ),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('inside init state...');
    // printCurrentUserData();
    navigateToCorrectPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                "Madhyam",
                style: TextStyle(
                  fontFamily: 'TitleFont',
                  fontSize: 50.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            SpinKitThreeBounce(
              color: Colors.white,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
