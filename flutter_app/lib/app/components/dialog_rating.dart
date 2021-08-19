import 'package:flutter/material.dart';
import 'package:flutter_app/utils/AppDimens.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DialogRating extends StatefulWidget {

  final int? finalRating;

  DialogRating({this.finalRating});

  @override
  _DialogRatingState createState() => _DialogRatingState();

}

class _DialogRatingState extends State<DialogRating> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: AppDimens.mediumMargin),
            child: Text("Rating: $rating/5"),
          ),
          RatingBar.builder(
            initialRating: 0,
            direction: Axis.horizontal,
            itemBuilder: (context, index) {
              return Icon(Icons.star,
                  color: Colors.amber);
            },
            onRatingUpdate: (rating) {
              setState(() {
                this.rating = rating.truncate();
              });
            },
          ),
        ],
      ),
    );
  }

}