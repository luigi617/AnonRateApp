import 'package:anon_rate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => RatingPageState();
}

class RatingPageState extends State<RatingPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: Text("AnonRate", style: Theme.of(context).appBarTheme.titleTextStyle,),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 50),
              child: Column(
                children: const [
                  Text("Search ..."),
                  SizedBox(height: 5,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text("People recently rated"),
            SizedBox(height: 10,),
            Row(
              children: [
                recentUser(),
                const SizedBox(width: 10,),
                recentUser(),
                const SizedBox(width: 10,),
                recentUser(),
                const SizedBox(width: 10,),
                recentUser(),
                const SizedBox(width: 10,),
                recentUser(),
                const SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 30,),
            Text("People recently commented"),
            SizedBox(height: 10,),
            Row(
              children: [
                recentUser(),
                const SizedBox(width: 10,),
                recentUser(),
              ],
            ),
            
            
          
          ]
        )
      ),
      
    );
  }

  Widget recentUser({String imageUrl = "https://via.placeholder.com/50", String username = "usernamehfakshfaj"}){
    return Container(
      width: 60,
      // height: 50,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 50,
            width: 50,
          ),
          Text(username, overflow: TextOverflow.ellipsis, softWrap: false,),
        ],
      )
    );
  }
}
