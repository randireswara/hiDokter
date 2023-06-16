import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword(
      {super.key,
      required this.btnIcon,
      required this.title,
      required this.subTitle,
      required this.onTap});

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(
              btnIcon,
              size: 60,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
