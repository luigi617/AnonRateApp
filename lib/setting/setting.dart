import 'package:anon_rate_app/api/user.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/model/user.dart';
import 'package:anon_rate_app/widget/userAvatar.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 50),
          children: [
            row(name: "Account", onTap: (){}),
            const Divider(height: 0),
            row(name: "Privacy", onTap: (){}),
            const Divider(height: 0),
            row(name: "Log Out", onTap: (){
              UserAPI.logOut();
              Navigator.pushNamedAndRemoveUntil(context, "/login/", (route) => false);

            }),
            const Divider(height: 0),
          ]
        )
      )
    );
  }


  
  Widget row({required String name, required Function() onTap}){
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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


