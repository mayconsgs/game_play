import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum CategoryValues { ranked, duelo, diversao, none }

class RadioButtonWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final CategoryValues value;

  final CategoryValues? groupValue;
  final VoidCallback onChanged;

  const RadioButtonWidget({
    required this.iconPath,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  })  : assert(value != CategoryValues.none),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: groupValue == value ? 1 : 0.5,
      child: InkWell(
        onTap: onChanged,
        borderRadius: BorderRadius.circular(8),
        child: Container(
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      height: 48,
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: groupValue == value
                          ? Color(0xFFE51C44)
                          : Color(0xFF0A1033),
                      border: Border.all(
                        color: groupValue == value
                            ? Color(0xFFE51C44)
                            : Color(0xFF243189),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
