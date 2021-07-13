import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCardWidget extends StatelessWidget {
  final String iconPath;
  final String text;

  const CategoryCardWidget(
      {Key? key, required this.iconPath, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 23, 31, 82),
          const Color.fromARGB(255, 29, 39, 102),
        ], begin: Alignment.topCenter),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromARGB(255, 36, 49, 137),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 48,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
