import 'package:anon_rate_app/api/user.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/model/user.dart';
import 'package:anon_rate_app/widget/userAvatar.dart';
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

      body: SafeArea(
        child: FutureBuilder(
          future: UserAPI.getMyProfile(),
          builder: ((context, AsyncSnapshot<UserBase> snapshot) {
            if (snapshot.hasData){
              UserBase user = snapshot.data!;
              return ListView(
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
                          borderRadius: BorderRadius.circular(5.0),
                          child: UserAvatar(
                            user.avatarThumbnail,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.username, style: TextStyle(fontSize: TextStyleFeature.textLargeSize),),
                            const SizedBox(height: 10,),
                            Text("${user.lastName} ${user.firstName}"),
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const Divider(),
                  row(svgPath: 'assets/icons/earth.svg', name: "Posts", onTap: (){
                    Navigator.pushNamed(context, "/user/posts/", arguments: {"userId": user.id});
                  }),
                  const Divider(),
                  row(svgPath: 'assets/icons/rating.svg', name: "Ratings", onTap: (){}),
                  const Divider(),
                  row(svgPath: 'assets/icons/setting.svg', name: "Setting", onTap: (){}),
                  const Divider(),
                ]
              );
            }
            return Container();
          })
        ),
    ));
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
}


