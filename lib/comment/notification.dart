import 'package:anon_rate_app/constants.dart';
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
        child: ListView(
          children: [
           

            Notification(),
            Divider(),
            Notification(),
            Divider(),
            Notification(),
            Divider(),
            
            
          
          ]
        )
      ),
      
    );
  }

}

class Notification extends StatelessWidget{
  const Notification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Comment", style: TextStyle(fontSize: TextStyleFeature.textLargeSize),),
              RatingBar.builder(
                initialRating: 3,
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
          Text("comment content content content contentcontent contentcontent contentcontent contentcontent content"),
          const SizedBox(height: 5,),
          Align(
            alignment: Alignment.centerRight,
            child: Text("2 days ago", style: TextStyle(fontSize: TextStyleFeature.textXSmallSize),),
          )
        ],
      )
    );
  }

}
