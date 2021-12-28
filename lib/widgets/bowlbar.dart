import 'package:flutter/material.dart';

class BowlBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  // ignore: use_key_in_widget_constructors
  const BowlBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      elevation: .1,
      backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
