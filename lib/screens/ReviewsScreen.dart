import 'package:flutter/material.dart';
import 'package:flutter_app/models/ReviewModel.dart';
import 'package:flutter_app/models/UserModel.dart';
import 'package:flutter_app/models/UserRide.dart';
import 'package:flutter_app/screens/MyApp.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_app/shared/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReviewsScreen extends StatelessWidget {
  final DataBase db;
  final UserRide ride;
  final UserModel myUser;
  final UserModel reviewee;

  ReviewsScreen({this.db, this.ride, this.reviewee, this.myUser});

  double revRating;
  String reviewText;

  // i need url,name, AND PHONE from card(reviewee)
  //and
  //myUserModel to create ReviewModel

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Madhyam',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Theme.of(context).primaryColor,
        accentColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        fontFamily: 'AppFont',
        //cardColor: lightGreyBackground,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Theme.of(context).accentColor,
            fontFamily: 'AppFont',
            fontSize: 14.0,
          ),
          subtitle1: TextStyle(
            color: Theme.of(context).accentColor,
            fontFamily: 'AppFont',
            fontSize: 16.0,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyApp(
                                  db: db,
                                  selectedIndex: 1,
                                )),
                      );
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    'Please rate your ride',
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20.0, bottom: 20.0),
                  child: Text(
                    'Do let us know your thoughts.\nYour feedback matters!',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: new NetworkImage(
                                        reviewee.getUrlFromNameHash(
                                            genderInput: reviewee.gender))),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  reviewee.name,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: RatingBar.builder(
                            initialRating: 3,
                            itemCount: 5,
                            // ignore: missing_return
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.red,
                                  );
                                case 1:
                                  return Icon(
                                    Icons.sentiment_dissatisfied,
                                    color: Colors.redAccent,
                                  );
                                case 2:
                                  return Icon(
                                    Icons.sentiment_neutral,
                                    color: Colors.amber,
                                  );
                                case 3:
                                  return Icon(
                                    Icons.sentiment_satisfied,
                                    color: Colors.lightGreen,
                                  );
                                case 4:
                                  return Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Colors.green,
                                  );
                              }
                            },
                            onRatingUpdate: (rating) {
                              revRating = rating;
                              print(rating);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: TextField(
                            onChanged: (value) => reviewText = value,
                            obscureText: false,
                            //expands: true,
                            maxLines: 5,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                labelText: "Enter your review here"),
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (revRating == null && reviewText == null) {
                        Fluttertoast.showToast(
                          msg: 'Please re-enter a valid rating and/or text',
                          timeInSecForIosWeb: 1,
                        );
                      } else {
                        var review = ReviewModel(
                          uid: reviewee.uid,
                          name: myUser.name,
                          imageUrl: myUser.getUrlFromNameHash(
                              genderInput: myUser.gender),
                          reviewText: this.reviewText,
                          rating: this.revRating,
                        );
                        db.createReviewModel(review);
                        await db.updateRideToFinished(ride, reviewee);
                        //TODO delete the Ride from the public list . It's over..
                        //db.deleteRideModel(ride);
                        //navigate to ridescreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyApp(db: db, selectedIndex: 1),
                          ),
                        );
                      }
                    }, //onPressed
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    style: primaryButton,
                  ),
                ),
                // RatingBar(
                //   initialRating: 5,
                //   minRating: 1,
                //   direction: Axis.horizontal,
                //   allowHalfRating: true,
                //   itemCount: 5,
                //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                //   itemBuilder: (context, _) => Icon(
                //     Icons.star,
                //     color: Colors.amber,
                //   ),
                //   onRatingUpdate: (rating) {
                //     revRating = rating;
                //     print(rating);
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
                      showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('This is the title.'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('This is a test alert dialog box.'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('I get it.'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text('Or not.'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      */
