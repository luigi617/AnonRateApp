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
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Palette.darkGrey,
            fontWeight: TextStyleFeature.boldTextWeight,
            fontSize: TextStyleFeature.textAppBar,
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