import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/widget/userAvatar.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchedUserPage extends StatefulWidget {
  const SearchedUserPage(
    {required this.userId,
    required this.username,
    required this.avatar,
    this.lastName = "",
    this.firstName = "",
    Key? key}
  ) : super(key: key);
  final int userId;
  final String avatar;
  final String username;
  final String lastName;
  final String firstName;
  @override
  State<SearchedUserPage> createState() => SearchedUserPageState();
}

class SearchedUserPageState extends State<SearchedUserPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Container(),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: UserAvatar(widget.avatar, height: 80, width: 80,),
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.username, style: const TextStyle(
                        fontSize: TextStyleFeature.textLargeSize,
                        color: Palette.usernameColor,
                        fontWeight: TextStyleFeature.mediumTextWeight,
                      ),),
                      const SizedBox(height: 10,),
                      Text("${widget.lastName} ${widget.firstName}"),
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
            const Divider(height: 0),
            const SizedBox(height: 15,),
            row(svgPath: 'assets/icons/earth.svg', name: "Posts", onTap: (){
              Navigator.pushNamed(context, "/user/posts/", arguments: {"userId": widget.userId});
            }),
            const Divider(height: 0),
            row(svgPath: 'assets/icons/rating.svg', name: "Ratings", onTap: (){}),
            const Divider(),
            actionRow(
              name: "Rate",
              onTap: (){
                Navigator.pushNamed(context, "/rating-creation/", arguments: {"recepientId": widget.userId});
            }),
            const Divider(),
            
          ]
        )
      ),
      
    );
  }


  Widget row({required String svgPath, required String name, required Function() onTap}){
    return InkWell(
      onTap: onTap,
      child: Padding(
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
            const Expanded(
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
      ),
    );
  }
  Widget actionRow({required String name, required Function() onTap,}){
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(color: Colors.blue[900]),),
          ],
        ),
      ),
    );
  }
}


