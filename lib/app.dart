import 'package:anon_rate_app/api/request.dart';
import 'package:anon_rate_app/authentication/logIn.dart';
import 'package:anon_rate_app/authentication/signup/signupAccount.dart';
import 'package:anon_rate_app/authentication/signup/signupUsername.dart';
import 'package:anon_rate_app/authentication/signup/signupPassword.dart';
import 'package:anon_rate_app/post/postCreation.dart';
import 'package:anon_rate_app/rating/createRating.dart';
import 'package:anon_rate_app/setting/setting.dart';
import 'package:anon_rate_app/user/searchedUser.dart';
import 'package:anon_rate_app/user/userPosts.dart';
import 'package:anon_rate_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:anon_rate_app/bottomNavigationBar.dart';
import 'package:anon_rate_app/constants.dart';


class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppView();
  
}

class _AppView extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  // NavigatorState get _navigator => _navigatorKey.currentState;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Palette.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "OpenSans",
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontSize: TextStyleFeature.textNormalSize,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Palette.darkGrey,
            fontWeight: TextStyleFeature.boldTextWeight,
            fontSize: TextStyleFeature.textAppBar,
          ),
        )
      ),
      navigatorKey: _navigatorKey,
      // initialRoute: '/',
      home: FutureBuilder(
        future: AccessToken.getToken(),
        builder: (BuildContext context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(); // TODO
          } else {
            if (snapshot.hasData){
              if (snapshot.data.toString().isNotEmpty){
                return const BottomNavigation();
              }
            }
            return const LogInUsernamePage();
          }
          
        }
      ),
      routes: {
        '/home/': (context){
          return const BottomNavigation();
        } ,
        '/login/': (context){
          return const LogInUsernamePage();
        } ,
        '/post/creation/': (context){
          return const PostCreationPage();
        } ,
        '/login/username/': (context){
          return const LogInUsernamePage();
        } ,
        '/signup/username/': (context){
          return const SignUpUsernamePage();
        } ,
        '/setting/': (context){
          return const SettingPage();
        } ,
        
      },
      onGenerateRoute: (RouteSettings settings) {
        final Object? args = settings.arguments;
        switch (settings.name) {
          case '/signup/password/':
              return MaterialPageRoute(
                builder: (context) {
                  return SignUpPasswordPage(
                    username: mapGet(args, "username"),
                  );
                }
              );
          case '/signup/account/':
              return MaterialPageRoute(
                builder: (context) {
                  return SignUpAccountPage(
                    id: mapGet(args, "id"),
                  );
                }
              );
          case '/search/user/':
              return MaterialPageRoute(
                builder: (context) {
                  return SearchedUserPage(
                    userId: mapGet(args, "userId"),
                    username: mapGet(args, "username"),
                    avatar: mapGet(args, "avatar"),
                    lastName: mapGet(args, "lastName"),
                    firstName: mapGet(args, "firstName"),
                  );
                }
              );
          case '/rating-creation/':
              return MaterialPageRoute(
                builder: (context) {
                  return RatingCreationPage(
                    recepientId: mapGet(args, "recepientId"),
                  );
                }
              );
          case '/user/posts/':
              return MaterialPageRoute(
                builder: (context) {
                  return UserPostPage(
                    userId: mapGet(args, "userId"),
                  );
                }
              );
          default:
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return const Center(child: Text('Error'));
        });
      }
    );
  }

  
}