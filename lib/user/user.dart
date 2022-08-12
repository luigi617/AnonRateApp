import 'package:anon_rate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: CustomAppBar(
      //   title: Text("Home", style: Theme.of(context).appBarTheme.titleTextStyle,),
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 50),
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: CachedNetworkImage(
                      imageUrl: "https://via.placeholder.com/80",
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("username", style: TextStyle(fontSize: TextStyleFeature.textLargeSize),),
                      const SizedBox(height: 10,),
                      Text("Last name and first name"),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: 80,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        ),
                      )
                    )
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 15,),
            const Divider(),
            const SizedBox(height: 15,),
            row(name: "Posts"),
            const Divider(),
            row(name: "Ratings"),
            const Divider(),
            row(name: "Comments"),
            const Divider(),
            row(name: "Setting"),
            const Divider(),

            
          ]
        )
      ),
      
    );
  }


  Widget row({String svgPath = 'assets/icons/nothing.svg', String name = "Posts"}){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: SvgPicture.asset(svgPath, height: 30, width: 30, color: Palette.grey),
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 15,
              ),
            )
          )
        ],
      ),
    );
  }
}


