import 'package:flutter/material.dart';

Widget TextFormWidget({
  required var Control,
  required var txt,
  required IconData preficon,
  void Function()? onTap,
  var sufficon = null,
  bool ispass = false,
  TextInputType type = TextInputType.emailAddress,
  required BuildContext context,
}) =>
    TextFormField(
      controller: Control,
      cursorColor: Theme.of(context).accentColor,
      decoration: InputDecoration(
        iconColor: Theme.of(context).accentColor,
        labelText: "$txt",
        labelStyle: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(
          preficon,
          color: Theme.of(context).accentColor,
        ),
        suffixIcon: (sufficon != null)
            ? InkWell(
                onTap: onTap,
                child: Icon(
                  sufficon,
                  color: Theme.of(context).accentColor,
                ))
            : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      keyboardType: type,
      obscureText: ispass,
      validator: (value) {
        if (value!.isEmpty) {
          return "$txt must not be empty";
        }
        return null;
      },
    );
