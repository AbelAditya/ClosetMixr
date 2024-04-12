import 'package:flutter/material.dart';

class Screensize{
  static h(context){
    return MediaQuery.of(context).size.height/812;
  }
  static w(context){
    return MediaQuery.of(context).size.width/375;
  }
}