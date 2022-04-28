import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/LoginScreen.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_app/shared/constant.dart';
import 'package:flutter_app/models/ReviewModel.dart';
import 'package:flutter_app/models/UserModel.dart';
import 'package:flutter_app/screens/ProfileEditScreen.dart';
import 'package:flutter_app/widgets/ReviewCard.dart';

class ProfileScreen extends StatelessWidget {
  final DataBase db;
  ProfileScreen({
    @required this.db,
  });

  Future<UserModel> futureUser;
  Future<List<ReviewModel>> futureReviews;
  //List<Widget> reviewWidgetList = [];

  List<Widget> reviewCardsWidgetsFromList(List<ReviewModel> reviews) {
    List<Widget> reviewWidgetList = [];
    if (reviews.isEmpty || reviews == null) {
      reviewWidgetList.add(
        Text('You have no reviews yet'),
      );
    } else {
      for (var item in reviews) {
        reviewWidgetList.add(ReviewCard(reviewModel: item));
      }
    }
    return reviewWidgetList;
  }

  double getRatingAverage(List<ReviewModel> reviewsList) {
    if (reviewsList.isEmpty) {
      return 0.0;
    } else {
      double sum = 0;
      for (var item in reviewsList) {
        var currentRating = item.rating;
        sum = sum + currentRating;
      }
      return sum / reviewsList.length;
    }
  }

  void getDataFromDb() {
    futureUser = db.getCurrentUserModel();
    futureReviews = db.getCurrentUserReviews();
  }

  void printReviewList() async {
    List reviews = await db.getCurrentUserReviews();
    print('!!!!REVIEWS IN DB:   $reviews');
  }

  @override
  Widget build(BuildContext context) {
    printReviewList();
    getDataFromDb();
    UserModel initialUser = UserModel(
      name: 'waiting...',
      gender: null,
      uid: 'waiting...',
      phone: 'waiting...',
      email: 'waiting...',
      rating: 0.0,
      carInfo: 'waiting...',
    );
    UserModel errorUser = UserModel(
      name: 'ERROR',
      gender: Gender.nonBinary,
      uid: 'ERROR',
      phone: 'ERROR',
      email: 'ERROR',
      rating: 0.0,
      carInfo: 'ERROR',
    );

    Widget userScreen(
        UserModel userModel, Future<List<ReviewModel>> futureReviews) {
      //addReviewCards(reviews);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Madhyam',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Theme.of(context).primaryColor,
          accentColor: Theme.of(context).accentColor,
          backgroundColor: Theme.of(context).backgroundColor,
          fontFamily: 'AppFont',
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditScreen(
                          db: this.db,
                          isNewUser: false,
                        )),
              );
            },
            child: Icon(Icons.edit),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: new NetworkImage(
                    userModel.getUrlFromNameHash(genderInput: userModel.gender),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0.0),
                  child: Text(
                    userModel.name,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Text(
                        'My Rating:',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FutureBuilder<List<ReviewModel>>(
                              future: futureReviews,
                              initialData: [],
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<ReviewModel>> snapshot) {
                                if (snapshot.hasData) {
                                  print('We have rating!!!');
                                  return Text(
                                    getRatingAverage(snapshot.data)
                                        .toString()
                                        .substring(0, 3),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  print('error');
                                  return Text(
                                    'error',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  );
                                } else {
                                  //waiting...
                                  print('waiting for rating');
                                  return Column(
                                    children: <Widget>[
                                      Center(
                                        child: SizedBox(
                                          child: CircularProgressIndicator(),
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                          Icon(
                            Icons.star,
                            size: 15.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Personal Info',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(userModel.phone),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(userModel.email),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                      child: Text(
                        'Car Info',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: ListTile(
                    leading: Icon(Icons.directions_car),
                    title: Text(userModel.carInfo),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder<List<ReviewModel>>(
                  future: futureReviews,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ReviewModel>> snapshot) {
                    if (snapshot.hasData) {
                      print('We have reviews!!!');
                      return Column(
                        children: reviewCardsWidgetsFromList(snapshot.data),
                      );
                    } else if (snapshot.hasError) {
                      print('error in review list');
                      print('error data: ${snapshot.data}');
                      return Column(
                        children: reviewCardsWidgetsFromList([]),
                      );
                    } else {
                      //waiting...
                      print('waiting reviews');
                      return Column(
                        children: <Widget>[
                          Center(
                            child: SizedBox(
                              child: CircularProgressIndicator(),
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 20.0,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      dynamic result = FirebaseAuth.instance.signOut();
                      if (result == null) {
                        print('Error occured while log out');
                      } else {
                        await Future.delayed(const Duration(seconds: 1), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                db: db,
                              ),
                            ),
                          );
                        });
                      }
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                      ),
                    ),
                    style: secondaryButton,
                  ),
                )
              ]),
            ),
          ),
        ),
      );
    }

    return FutureBuilder<UserModel>(
        //futureReviews
        future: futureUser,
        initialData: initialUser,
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            print('we have profile data!!!');
            print(snapshot.data);
            return userScreen(snapshot.data, this.futureReviews);
          } else if (snapshot.hasError) {
            print('error');
            return userScreen(errorUser, this.futureReviews);
          } else {
            //waiting...
            print('waiting');
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 100,
                height: 100,
              ),
            );
          }
        });
  }
}
