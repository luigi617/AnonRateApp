import 'package:anon_rate_app/api/user.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/model/user.dart';
import 'package:anon_rate_app/widget/userAvatar.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        title: Container(
          width: double.infinity,
          // height: 40,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              autocorrect: false,
              style: const TextStyle(fontSize: TextStyleFeature.textSmallSize),
              decoration: InputDecoration(
              
                contentPadding: const EdgeInsets.all(8),
                isDense: true,
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset('assets/icons/search.svg', height: 15, width: 15, color: Palette.grey),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 20,
                  minWidth: 20,
                ),
                hintText: 'Search...',
                
                border: const OutlineInputBorder(
                  gapPadding: 0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none
                )),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("People near you"),
            ),
            const SizedBox(height: 10,),
            FutureBuilder(
              future: UserAPI.userList(1),
              builder: ((context, AsyncSnapshot<List<UserList>> snapshot) {
                if (snapshot.hasData){
                  List<UserList> users = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length * 2,
                    itemBuilder: ((context, index) {
                      if (index % 2 == 0){
                        return recommendedUser(
                          id: users[index~/2].id,
                          imageUrl: users[index~/2].avatarThumbnail,
                          username: users[index~/2].username,
                          rate: users[index~/2].rate,
                          lastName: users[index~/2].lastName,
                          firstName: users[index~/2].firstName,
                        );
                      } else {
                        return const Divider();
                      }
                    })
                  );

                }
                return Container();
              })
            ),
            
          
          ]
        )
      ),
      
    );
  }

  Widget recommendedUser({
    required int id,
    String imageUrl = "https://via.placeholder.com/50",
    required String username,
    String rate = "no rates",
    String lastName = "",
    String firstName = "",
  }){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          "/search/user/",
          arguments: {
            "userId": id,
            "avatar": imageUrl,
            "username": username,
            "lastName": lastName,
            "firstName": firstName,
          }
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: UserAvatar(imageUrl, height: 47, width: 47,),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      // backgroundColor: Colors.amber,
                      fontWeight: TextStyleFeature.mediumTextWeight,
                      fontSize: TextStyleFeature.textLargeSize,
                      color: Palette.usernameColor
                    ),
                  ),
                  
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(rate, style: const TextStyle(fontSize: TextStyleFeature.textXSmallSize),),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
    
  }
}
