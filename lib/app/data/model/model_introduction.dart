import 'package:flutter/animation.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;
  final String counterText;
  final Color bgColor;
  final double height;

  final String buttonText;

  OnBoardingModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.counterText,
      required this.bgColor,
      required this.height,
      required this.buttonText});
}
