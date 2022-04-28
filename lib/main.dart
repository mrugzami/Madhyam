
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/AuthScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Welcome());
}

class Welcome extends StatelessWidget {
  final greenPrimary = Color(0xFF1DB954 );
  final greenAccent = Color(0xFF333333);
  final greenBackground = Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: greenPrimary,
        accentColor: greenAccent,
        backgroundColor: greenBackground,
        fontFamily: 'AppFont',
      ),
      home: AuthScreen(),
    );
  }
}
