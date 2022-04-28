import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const inputTextDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
    borderSide: BorderSide(color: Colors.grey, width: 3.0),
  ),
);

dynamic primaryButton = ElevatedButton.styleFrom(
  primary: const Color(0xFF1DB954),
  onPrimary: Colors.white,
  padding: EdgeInsets.symmetric(vertical: 15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(32.0),
  ),
);

dynamic secondaryButton = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.red),
    ),
  ),
);

dynamic accentButton = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.black45),
    ),
  ),
);

dynamic loadingWidget = SpinKitThreeBounce(
  color: Colors.white,
  size: 30.0,
);
