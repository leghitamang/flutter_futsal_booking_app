import 'package:flutter/material.dart';

class BookAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Icon(Icons.share, color: Colors.white),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.favorite_border, color: Colors.white),
        ),
      ],
    );
  }
}