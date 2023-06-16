import 'package:flutter/material.dart';

import '../../../data/model/model_introduction.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget(
      {Key? key, required this.model, required this.onTap})
      : super(key: key);

  final OnBoardingModel model;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(model.image, height: model.height * 0.4),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                model.subTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.counterText,
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Text(model.buttonText),
          )
        ],
      ),
    );
  }
}
