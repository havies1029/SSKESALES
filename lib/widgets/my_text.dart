
import 'package:flutter/material.dart';

class MyText{

  static TextStyle? display4(BuildContext context){
    return Theme.of(context).textTheme.headline1;
  }

  static TextStyle? display3(BuildContext context){
    return Theme.of(context).textTheme.headline2;
  }

  static TextStyle? display2(BuildContext context){
    return Theme.of(context).textTheme.headline3;
  }

  static TextStyle? display1(BuildContext context){
    return Theme.of(context).textTheme.headline4;
  }

  static TextStyle contentStyle(){
    return const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  }

  static TextStyle contentStyleHeader(){
    return const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  }

  static TextStyle headerStyle(){
    return const TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  }

  static TextStyle? titleLarge(BuildContext context){
    return Theme.of(context).textTheme.titleLarge;
  }

  static TextStyle? titleMedium(BuildContext context){
    return Theme.of(context).textTheme.titleMedium;
  }
    
  static TextStyle? titleSmall(BuildContext context){
    return Theme.of(context).textTheme.titleSmall;
  }

  static TextStyle? bodyLarge(BuildContext context){
    return Theme.of(context).textTheme.bodyLarge;
  }

  static TextStyle? bodyMedium(BuildContext context){
    return Theme.of(context).textTheme.bodyMedium;
  }

    static TextStyle? bodySmall(BuildContext context){
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle? caption(BuildContext context){
    return Theme.of(context).textTheme.caption;
  }

  static TextStyle? button(BuildContext context){
    return Theme.of(context).textTheme.button!.copyWith(
        letterSpacing: 1
    );
  }

  static TextStyle? subtitle(BuildContext context){
    return Theme.of(context).textTheme.subtitle2;
  }

  static TextStyle? overline(BuildContext context){
    return Theme.of(context).textTheme.overline;
  }
}