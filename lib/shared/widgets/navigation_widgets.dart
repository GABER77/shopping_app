import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateTo(context,page) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => page,
  ),
);

void navigateToAndClose(context, page) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => page,
  ),
    (route) => false,
);

void navigateFrom(BuildContext context){
  Navigator.pop(context);
}