import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      // color: Colors.orange,
      child: Hero(
        tag: 'avatar',
        child: CircleAvatar(
          radius: 80,
          backgroundImage: NetworkImage(
              'https://widgetwhats.com/app/uploads/2019/11/free-profile-photo-whatsapp-4.png'),
        ),
      ),
    );
  }
}
