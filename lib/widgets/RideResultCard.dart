import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserModel.dart';
import 'package:flutter_app/models/RidesModel.dart';
import 'package:flutter_app/shared/constant.dart';

class RideResultCard extends StatelessWidget {
  final RidesModel ridesModel;
  final Function(RidesModel) onPressed;
  final Color darkBlueColor = Color.fromRGBO(26, 26, 48, 1.0);

  RideResultCard({this.ridesModel, this.onPressed});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = ridesModel.driver;
    String from, to;
    double rating = double.parse((userModel.rating).toStringAsFixed(1));
    if (ridesModel.fromText.length > 400)
      from = ridesModel.fromText.substring(0, 37) + "...";
    else
      from = ridesModel.fromText;

    if (ridesModel.toText.length > 400)
      to = ridesModel.toText.substring(0, 37) + "...";
    else
      to = ridesModel.toText;

    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(10.0),
            leading: CircleAvatar(
              backgroundImage: new NetworkImage(
                  userModel.getUrlFromNameHash(genderInput: userModel.gender)),
              radius: 28.0,
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                userModel.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(rating.toString()),
                Icon(
                  Icons.star,
                  size: 15.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              child: Text(from),
              height: 35,
            ),
          ),
          Icon(Icons.arrow_downward),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              child: Text(to),
              height: 35,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              onPressed: () {
                onPressed(ridesModel);
              },
              child: Text(
                'Show Details',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16.0,
                ),
              ),
              style: accentButton,
            ),
          )
        ],
      ),
    );
  }
}
