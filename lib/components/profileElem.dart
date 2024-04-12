import 'package:closet/model/ScreenSize.dart';
import 'package:flutter/material.dart';

class ProfileElem extends StatelessWidget {
  const ProfileElem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: Screensize.w(context)*40,
      width: Screensize.w(context)*40,
      child: Icon(Icons.person),
    );
  }
}