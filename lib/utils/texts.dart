import 'package:flutter/material.dart';
import 'colors.dart';

Text textHeader(String text) => Text(
  text,
  style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold, color: darkPurple),
);

Text textSubTitle(String text) => Text(
    text,
    style: TextStyle(color: greyColor,fontSize: 14)
);