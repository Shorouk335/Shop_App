import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> FlutterToAstItem ({
  required String txt ,
  required ToastStates state ,
}) {
  return Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseColorState(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates {SUCCESS ,ERROR ,WARNING}

Color chooseColorState (ToastStates state){
  Color? color ;
  switch (state) {
    case ToastStates.SUCCESS :
      color = Colors.green ;
      break ;
    case ToastStates.ERROR :
      color = Colors.red ;
      break ;
    case ToastStates.WARNING :
      color = Colors.yellow ;
      break ;
  }
  return color ;

}

