import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatelessWidget{
  
  final String avatar;
  final double height;
  final double width;
  const UserAvatar(
    this.avatar,
    {this.height = 50,
    this.width = 50,
      Key? key}
  ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (avatar.isEmpty || avatar.length == 0){
      return Image.asset("assets/images/user.png", height: height, width: width);
    }
    return CachedNetworkImage(
      imageUrl: avatar,
      // placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      height: height,
      width: width,
    );
  }

}