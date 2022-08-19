import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/model/post.dart';
import 'package:dio/dio.dart';

class PostAPI{
  static Future<Response> createPost(String content, List<MultipartFile> images)async{
    FormData formData = FormData.fromMap({
      "content": content,
      "post_images": images,
    });
    Response response = await httpUtil().post(
      '/posts/',
      data: formData,
    );
    return response;
  }
  static Future<List<Post>> postList(int page, {int? userId})async{
    Response response = await httpUtil().get(
      '/posts/',
      queryParameters: {
        "page": page,
        "userId": userId,
      }
    );
    List<Post> posts = [];

    for (var post in response.data["results"]){
      posts.add(Post.fromJson(post));
    }
    return posts;
  }
}