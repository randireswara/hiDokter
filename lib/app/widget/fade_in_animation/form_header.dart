import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.cra = CrossAxisAlignment.start,
    this.alignText = TextAlign.center,
  });

  final String image, title, subtitle;
  final CrossAxisAlignment cra;
  final TextAlign alignText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: cra,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.2,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: alignText,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: alignText,
        ),
      ],
    );
  }
}
