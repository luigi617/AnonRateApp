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
  static Future<Response> logIn(String username, String password)async{
    Response response = await AccessToken.logInToken(username, password);
    return response;
  }
  static Future<Response> logOut()async{
    Response response = await AccessToken.revokeToken();
    return response;
  }
}