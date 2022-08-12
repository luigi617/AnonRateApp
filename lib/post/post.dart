import 'package:anon_rate_app/constants.dart';
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
        title: Text("Post", style: Theme.of(context).appBarTheme.titleTextStyle,),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add, color: Colors.black,))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Post(),
            Divider(),
            Post(),
            Divider(),
            Post(),
            Divider(),
            Post(),
            Divider(),
            Post(),
            Divider(),
            Post(),
            Divider(),
          
          ]
        )
      ),
      
    );
  }
}


class Post extends StatelessWidget {

  
  const Post({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: CachedNetworkImage(
                imageUrl: "https://via.placeholder.com/50",
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("username", style: TextStyle(fontSize: TextStyleFeature.textLargeSize),),
                const SizedBox(height: 5,),
                Text("post content"),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "https://via.placeholder.com/80",
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(width: 10,),
                    CachedNetworkImage(
                      imageUrl: "https://via.placeholder.com/80",
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 80,
                      width: 80,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
    );
  }

}
