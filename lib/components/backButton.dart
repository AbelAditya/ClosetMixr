import 'package:closet/model/ScreenSize.dart';
import 'package:flutter/material.dart';

class Backbutton extends StatelessWidget {
  const Backbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screensize.w(context)*41,
      width: Screensize.w(context)*41,
      decoration: BoxDecoration(
        color: Color(0xFFE8ECF4),
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: Screensize.w(context)*10),
      child: Icon(Icons.arrow_back_ios,)
    );
  }
}