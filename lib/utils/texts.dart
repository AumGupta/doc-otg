import 'package:flutter/material.dart';
import 'constants.dart';

Text textHeader(String text, {double size = 24}) => Text(
  text,
  style: TextStyle(fontSize: size,fontWeight: FontWeight.bold, color: darkPurple),
);

Text textSubTitle(String text, {double size = 16}) => Text(
    text,
    style: TextStyle(color: greyColor,fontSize: size)
);

Text textMedium(String text, {double size = 16}) => Text(
  text,
  style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white),
);

Text textNormal(String text, {double size = 16}) => Text(
  text,
  style: TextStyle(
      fontSize: size,
      color: Colors.white),
);

