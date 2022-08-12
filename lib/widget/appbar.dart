import 'package:flutter/material.dart';

import 'package:anon_rate_app/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final Widget title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;

  CustomAppBar({Key? key, 
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
  }) : preferredSize = const Size.fromHeight(50.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: title,
        leading: automaticallyImplyLeading
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Palette.blue,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: actions
        );
  }
}