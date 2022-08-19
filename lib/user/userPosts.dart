
import 'package:anon_rate_app/api/post.dart';
import 'package:anon_rate_app/constants.dart';
import 'package:anon_rate_app/model/post.dart';
import 'package:anon_rate_app/widget/imagesDisplay.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';

class UserPostPage extends StatefulWidget {
  const UserPostPage({required this.userId, Key? key}) : super(key: key);
  final int userId;

  @override
  State<UserPostPage> createState() => _UserPostPageState();
}

class _UserPostPageState extends State<UserPostPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: Container(),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: PostAPI.postList(1, userId: widget.userId),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      DateTime.parse(post.dateCreated).day.toString(),
                      style: const TextStyle(
                        fontSize: TextStyleFeature.textXXXLargeSize,
                        fontWeight: TextStyleFeature.semiBoldTextWeight
                      ),
                    ),
                    const SizedBox(width: 3,),
                    Text(
                      getMonthName(DateTime.parse(post.dateCreated)),
                      style: const TextStyle(
                        fontSize: TextStyleFeature.textSmallSize,
                        fontWeight: TextStyleFeature.mediumTextWeight
                      ),
                    ),
                  ],
                ),
                Text(
                  DateTime.parse(post.dateCreated).year.toString(),
                  style: const TextStyle(
                    fontSize: TextStyleFeature.textSmallSize,
                    fontWeight: TextStyleFeature.mediumTextWeight
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const SizedBox(height: 5,),
                  if (post.content.isNotEmpty)
                  Text(post.content),
                  const SizedBox(height: 10,),
                  if (post.postImages.isNotEmpty)
                  PostImagesDisplay(post.postImages.map((e) => e.file).toList()),
                  const SizedBox(height: 10,),
                  
                ],
              )
            ),
          ],
        ),
    );
  }
  String getMonthName(DateTime date){
    List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ]; 
    return months[date.month - 1].substring(0, 3);
  }

  

}
