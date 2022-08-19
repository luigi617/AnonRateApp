import 'package:anon_rate_app/api/request.dart';

import 'package:anon_rate_app/model/user.dart';
import 'package:dio/dio.dart';

class UserAPI{
  
  static Future<List<UserList>> userList(int page)async{
    Response response = await httpUtil().get(
      '/users/',
      queryParameters: {"page": page}
    );
    List<UserList> users = [];

    for (var user in response.data["results"]){
      users.add(UserList.fromJson(user));
    }
    return users;
  }
  static Future<UserBase> getMyProfile()async{
    Response response = await httpUtil().get('/users/me/');
    UserBase user = UserBase.fromJson(response.data);
    return user;
  }
}