import 'package:flutter/material.dart';

class BowlBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  BowlBar({required this.title});

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      elevation: .1,
      backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(50.0);
}
