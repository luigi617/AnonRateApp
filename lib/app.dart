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
        fontFamily: 'Cochin',
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize1,
          ),
          bodyText2: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize1,
          ),
          subtitle1: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize2,
          ),
          subtitle2: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize1,
          ),
          headline6: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize4,
          ),
          headline5: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize5,
          ),
          headline4: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize6,
          ),
          headline3: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize7,
          ),
          headline2: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize8,
          ),
          headline1: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize9,
          ),
          button: TextStyle(
            color: Palette.darkGrey,
            fontSize: TextStyleFeature.textSize3,
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Palette.darkGrey,
            fontWeight: TextStyleFeature.boldTextWeight,
            fontSize: TextStyleFeature.textSize4,
          ),
        )
      ),
      navigatorKey: _navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomNavigation(),
        
      },
      onGenerateRoute: (RouteSettings settings) {
        final Object? args = settings.arguments;
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