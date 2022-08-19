import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/model/rating.dart';
import 'package:dio/dio.dart';

class RatingAPI{
  static Future<Response> createRating(String content, int recipientId, int rating)async{
    FormData formData = FormData.fromMap({
      "content": content,
      "recipient": recipientId,
      "rating": rating == 0 ? null : rating,
    });
    Response response = await httpUtil().post(
      '/ratings/',
      data: formData,
    );
    return response;
  }
  static Future<List<Rating>> getRatingList(int page)async{

    Response response = await httpUtil().get(
      '/ratings/',
      queryParameters: {"page": page}
    );
    List<Rating> ratings = [];
    for (var rating in response.data["results"]){
      ratings.add(Rating.fromJson(rating));
    }
    return ratings;
  }
}