import 'package:anon_rate_app/api/rating.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/model/rating.dart';
import 'package:anon_rate_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Anon Notifications", style: Theme.of(context).appBarTheme.titleTextStyle,),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: RatingAPI.getRatingList(1),
          builder: ((context, AsyncSnapshot<List<Rating>> snapshot) {
            if (snapshot.hasData){
              List<Rating> ratings = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: ratings.length*2,
                itemBuilder: (context, index) {
                  if (index % 2 == 0){
                    return Notification(ratings[index ~/ 2]);
                  } else {
                    return const Divider(height: 0);
                  }
                },
              );
            }
            return Container();
          }),
        ),
        
      ),
      
    );
  }

}

class Notification extends StatelessWidget{
  final Rating rating;
  const Notification(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(rating.rating == 0 ? "Comment" : "Rating", style: TextStyle(fontSize: TextStyleFeature.textLargeSize),),
              RatingBar.builder(
                initialRating: rating.rating/20,
                minRating: 1,
                ignoreGestures: true,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Text(rating.content),
          const SizedBox(height: 5,),
          Align(
            alignment: Alignment.centerRight,
            child: Text(dateCreatedParse(rating.dateCreated), style: TextStyle(fontSize: TextStyleFeature.textXSmallSize),),
          )
        ],
      )
    );
  }

}
