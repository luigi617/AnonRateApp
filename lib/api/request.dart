import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secureStorage;


var storage = const secureStorage.FlutterSecureStorage();

class Oauth {


  // static const String identifier = "luIqsHXLvfkG1rodGzZHSdI8ZOQDKf5MjlbyKfsY";
  // static const String secret =
  //     "QJZ5G6dnSKAaEy3SQ2JJopKPmaRj9QzygJgatI8zJcF7Vyrx23RXAA6ChlIXAMJb6MZ0gzuKSyQTlWJBld3NcevRrOZ4JosuTE7xARTL9pry5s2OMDE8jNiLk52MajnY";
  static const String identifier = "HFV596tb2pLHuhQaJaETPrsP1ieON7gkEZ3KePjq";
  static const String secret =
      "4imuVlHX3OkFP4MdMepn7SNgzSlR2YQAEJO4OOmwhci028Lri0mpHLQMSBvBGo9Lgur96PFxiDqfDhefVt2fNhOtYxCqRQ8UDkX6Jo78zX06fj0rIUn81zbaJe1YnCMW";
}

class Url {
  static const String baseUrl = 'http://192.168.1.44:8000';
  static const String api = '$baseUrl/api';
  static const String oAuth = '$baseUrl/o';

}

class AccessToken {
  static Future<Response> logInToken(String username, String password) async {
   
    FormData data = FormData.fromMap(<String, dynamic>{
      "grant_type": "password",
      "client_id": Oauth.identifier,
      "client_secret": Oauth.secret,
      "username": username,
      "password": password,
    });
    Response response = await httpUtil(version: 'base').post("/o/token/", data: data);
    storage.write(key: "accessToken", value: response.data["access_token"]);
    storage.write(key: "refreshToken", value: response.data["refresh_token"]);

    return response;
  }
  static Future<String> getToken() async {
    String? token = await storage.read(key: "accessToken");
    if (token != null) {
      return "Bearer $token";
    }
    return '';
  }

  static Future<Response> revokeToken() async {
    final String? refreshToken = await storage.read(key: 'accessToken');
    var data = FormData.fromMap(<String, dynamic>{
      "token": refreshToken,
      "client_id": Oauth.identifier,
      "client_secret": Oauth.secret,
    });
    Response response = await httpUtil(version: 'base').post("/o/revoke_token/", data: data);
    storage.delete(key: "accessToken");
    storage.delete(key: "refreshToken");
    return response;
  }
  static Future<String?> refreshToken() async {
    final String? refreshToken = await storage.read(key: 'refreshToken');
    var data = FormData.fromMap(<String, dynamic>{
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
      "client_id": Oauth.identifier,
      "client_secret": Oauth.secret,
    });
    Response? response;
    
    try {
      response = await httpUtil(version: 'base').post("/o/token/", data: data);
    } catch (e) {
      if (e is DioError) {
        return null;
      }
    }

    if (response?.statusCode == 200) {
      storage.write(key: "accessToken", value: response?.data['access_token']);
      storage.write(key: "refreshToken", value: response?.data['refresh_token']);
      return response?.data['access_token'];
    }
    return null;
  }
}

Dio httpUtil({String version = 'api', Function? logOut}) {
  Dio dio = Dio();
  switch (version) {
    case 'api':
      dio.options.baseUrl = Url.api;
      break;
    default:
      dio.options.baseUrl = Url.baseUrl;
  }
  dio.options.connectTimeout = 150000; // 服务器链接超时，毫秒
  dio.options.receiveTimeout = 30000; // 响应流上前后两次接受到数据的间隔，毫秒
  dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (RequestOptions requestOptions, RequestInterceptorHandler requestInterceptorHandler) async {
    requestOptions.headers["Authorization"] = await AccessToken.getToken();
    // print(requestOptions.headers["Authorization"]);
    return requestInterceptorHandler.next(requestOptions); //continue
  }, onError: (DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    // print(error.message);
    // print(error.error);
    // print(error.response?.data.toString());
    // print(error.response?.statusMessage);
    if (error.response?.statusCode == 403 || error.response?.statusCode == 401) {
      String? token = await AccessToken.refreshToken();
      if (token == null) {
        if (logOut != null){
          logOut();
        }
        storage.delete(key: "accessToken");
        storage.delete(key: "refreshToken");
        return errorInterceptorHandler.next(error);
      }

      // requestOptions.headers["Authorization"] = "Bearer " + token;
      Response response = error.response!;
      response.requestOptions.headers["Authorization"] = "Bearer $token";

      Response newResponse = await _retry(response.requestOptions, dio);

      return errorInterceptorHandler.resolve(newResponse);

      // return dio.request(error.requestOptions.path, options: response);
    } 
    return errorInterceptorHandler.next(error);
  }, onResponse: (Response<dynamic> response, ResponseInterceptorHandler responseInterceptorHandler) {

    return responseInterceptorHandler.next(response);
  }));
  return dio;
}

Future<Response<dynamic>> _retry(RequestOptions requestOptions, Dio dio) async {
  final options = Options(
    method: requestOptions.method,
    headers: requestOptions.headers,
  );
  return dio.request<dynamic>(requestOptions.path,
      data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
}