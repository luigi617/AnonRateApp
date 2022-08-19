import 'package:flutter/material.dart';

import 'package:anon_rate_app/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final Widget title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double elevation;

  CustomAppBar({Key? key, 
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
  }) : preferredSize = const Size.fromHeight(50.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: elevation,
        centerTitle: false,
        leadingWidth: 56.0,
        title: title,
        leading: automaticallyImplyLeading
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Palette.blue,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: actions,
      
        );
  }
}