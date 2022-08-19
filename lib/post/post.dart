import 'dart:ui';

import 'package:anon_rate_app/api/post.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/model/post.dart';
import 'package:anon_rate_app/utils.dart';
import 'package:anon_rate_app/widget/imagesDisplay.dart';
import 'package:anon_rate_app/widget/userAvatar.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: Text("AnonRate", style: Theme.of(context).appBarTheme.titleTextStyle,),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/post/creation/");
            },
            icon: Icon(Icons.add_a_photo_outlined, color: Colors.black,))
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: PostAPI.postList(1),
          builder: ((context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData){
              List<Post> posts = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: posts.length*2,
                itemBuilder: ((context, index) {
                  if (index % 2 == 0){
                    return PostInformation(posts[index~/2]);
                  } else {
                    return const Divider(height: 0);
                  }
                })
              );
            }
            return Container();
          }),
        )
      ),
      
    );
  }
}


class PostInformation extends StatelessWidget {

  final Post post;
  const PostInformation(this.post, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: UserAvatar(post.user.avatarThumbnail, height: 47, width: 47,),
            ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user.username,
                    style: const TextStyle(
                      // backgroundColor: Colors.amber,
                      fontWeight: TextStyleFeature.mediumTextWeight,
                      fontSize: TextStyleFeature.textLargeSize,
                      color: Palette.usernameColor
                    ),
                  ),
                  
                  const SizedBox(height: 5,),
                  if (post.content.isNotEmpty)
                  Text(post.content),
                  const SizedBox(height: 10,),
                  if (post.postImages.isNotEmpty)
                  PostImagesDisplay(post.postImages.map((e) => e.file).toList()),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(dateCreatedParse(post.dateCreated), style: const TextStyle(fontSize: TextStyleFeature.textXSmallSize),),
                  )
                ],
              )
            ),
          ],
        ),
    );
  }

  

}
