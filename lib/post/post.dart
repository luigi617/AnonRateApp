import 'package:flutter/material.dart';
import 'package:anon_rate_app/widget/appbar.dart';

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
        title: Text("Home", style: Theme.of(context).appBarTheme.titleTextStyle,),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            Text("hello")
          ]
        )
      ),
      
    );
  }}
