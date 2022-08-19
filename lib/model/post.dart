import 'package:anon_rate_app/model/user.dart';


class PostImage {
  final int id;
  final String file;
  final int postId;

  PostImage({
    required this.id,
    required this.file,
    required this.postId,
    
  });

  factory PostImage.fromJson(Map json) {
    return PostImage(
      id: json['id'],
      file: json['file'],
      postId: json['post'],
      
    );
  }
}
class Post {
  final int id;
  final UserBase user;
  final String content;
  final String dateCreated;
  final List<PostImage> postImages;

  Post({
    required this.id,
    required this.user,
    required this.dateCreated,
    this.content = "",
    this.postImages = const [],
    
  });

  factory Post.fromJson(Map json) {
    List<PostImage> images = [];
    for (var img in json["images"]){
      images.add(PostImage.fromJson(img));
    }
    return Post(
      id: json['id'],
      user: UserBase.fromJson(json['user']),
      dateCreated: json['date_created'],
      content: json['content'],
      postImages: images,
    );
  }
}