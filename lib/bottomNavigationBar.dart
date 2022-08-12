
import 'package:anon_rate_app/comment/notification.dart';
import 'package:anon_rate_app/post/post.dart';
import 'package:anon_rate_app/rating/rating.dart';
import 'package:anon_rate_app/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:anon_rate_app/constants.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  
  // Bottom Navigation
  int _selectedIndex = 0;


  final List<Widget> _widgetOptions = <Widget>[
    const RatingPage(),
    const PostPage(),
    const NotificationPage(),
    const UserPage(),
  ];
  List<String> svgPath = <String>[
    'assets/icons/home.svg',
    'assets/icons/earth.svg',
    'assets/icons/comment.svg',
    'assets/icons/user.svg',
  ];
  List<String> selectedSvgPath = <String>[
    'assets/icons/nothing.svg',
    'assets/icons/nothing.svg',
    'assets/icons/comment.svg',
    'assets/icons/nothing.svg',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        onTap: (int index) => _onItemTapped(index),
        items: [
          for (int i = 0; i < svgPath.length; i++)
            BottomNavigationBarItem(
              icon: _buildBottomNav(i, svgPath[i]),
              activeIcon: _buildBottomActiveNav(i, svgPath[i]),
              label: '',
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(int index, String svgPath) {
    return Container(child: SvgPicture.asset(svgPath, height: 30, width: 30, color: Palette.grey));
  }

  Widget _buildBottomActiveNav(int index, String svgPath) {
    return Container(child: SvgPicture.asset(svgPath, height: 30, width: 30, color: Palette.blue));
  }
}
